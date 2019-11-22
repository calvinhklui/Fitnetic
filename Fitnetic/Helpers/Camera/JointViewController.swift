// Source: https://github.com/tucan9389/PoseEstimation-CoreML

import UIKit
import SwiftUI
import Vision
import CoreMedia
import os.signpost

final class JointViewController: UIViewController {
  
  let refreshLog = OSLog(subsystem: "com.tucan9389.PoseEstimation-CoreML", category: "InferenceOperations")
  
  public typealias DetectObjectsCompletion = ([PredictedPoint?]?, Error?) -> Void
  
  var jointView: DrawingJointView! // = DrawingJointView()
  
  // MARK: - Performance Measurement Property
  private let 👨‍🔧 = 📏()
  var isInferencing = false
  
  // MARK: - AV Property
  var videoCapture: VideoCapture!
  
  // MARK: - ML Properties
  // Core ML model
  typealias EstimationModel = model_cpm
  
  // Preprocess and Inference
  var request: VNCoreMLRequest?
  var visionModel: VNCoreMLModel?
  
  // Postprocess
  var postProcessor: HeatmapPostProcessor = HeatmapPostProcessor()
  var mvfilters: [MovingAverageFilter] = []
  
  init(jointView: DrawingJointView!) {
    self.jointView = jointView
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Controller Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // setup the model
    setUpModel()
    
    // setup camera
    setUpCamera()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.videoCapture.start()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.videoCapture.stop()
  }
  
  // MARK: - Setup Core ML
  func setUpModel() {
    if let visionModel = try? VNCoreMLModel(for: EstimationModel().model) {
      self.visionModel = visionModel
      request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestDidComplete)
      request?.imageCropAndScaleOption = .scaleFill
    } else {
      fatalError("cannot load the ml model")
    }
  }
  
  // MARK: - SetUp Video
  func setUpCamera() {
    videoCapture = VideoCapture()
    videoCapture.delegate = self
    videoCapture.fps = 30
    videoCapture.setUp(sessionPreset: .vga640x480) { success in
      
      if success {
        // add preview view on the layer
        if let previewLayer = self.videoCapture.previewLayer {
          previewLayer.frame = self.view.bounds
          previewLayer.videoGravity = .resizeAspectFill
          self.view.layer.addSublayer(previewLayer)
          
          self.jointView.frame = self.view.bounds
          self.jointView.backgroundColor = UIColor.clear
          self.view.addSubview(self.jointView)
        }
        
        // start video preview when setup is done
        self.videoCapture.start()
      }
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
}

// MARK: - VideoCaptureDelegate
extension JointViewController: VideoCaptureDelegate {
  func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame pixelBuffer: CVPixelBuffer?, timestamp: CMTime) {
    // the captured image from camera is contained on pixelBuffer
    if !isInferencing, let pixelBuffer = pixelBuffer {
      
      isInferencing = true
      
      // start of measure
      self.👨‍🔧.🎬👏()
      
      // predict!
      self.predictUsingVision(pixelBuffer: pixelBuffer)
    }
  }
}

extension JointViewController {
  // MARK: - Inferencing
  func predictUsingVision(pixelBuffer: CVPixelBuffer) {
    guard let request = request else { fatalError() }
    // vision framework configures the input size of image following our model's input configuration automatically
    let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
    
    if #available(iOS 12.0, *) {
      os_signpost(.begin, log: refreshLog, name: "PoseEstimation")
    }
    try? handler.perform([request])
  }
  
  // MARK: - Postprocessing
  func visionRequestDidComplete(request: VNRequest, error: Error?) {
    if #available(iOS 12.0, *) {
      os_signpost(.event, log: refreshLog, name: "PoseEstimation")
    }
    self.👨‍🔧.🏷(with: "endInference")
    if let observations = request.results as? [VNCoreMLFeatureValueObservation],
      let heatmaps = observations.first?.featureValue.multiArrayValue {
      
      /* =================================================================== */
      /* ========================= post-processing ========================= */
      
      /* ------------------ convert heatmap to point array ----------------- */
      var predictedPoints = postProcessor.convertToPredictedPoints(from: heatmaps)
      
      /* --------------------- moving average filter ----------------------- */
      if predictedPoints.count != mvfilters.count {
        mvfilters = predictedPoints.map { _ in MovingAverageFilter(limit: 3) }
      }
      for (predictedPoint, filter) in zip(predictedPoints, mvfilters) {
        filter.add(element: predictedPoint)
      }
      predictedPoints = mvfilters.map { $0.averagedValue() }
      /* =================================================================== */
      
      /* =================================================================== */
      /* ======================= display the results ======================= */
      DispatchQueue.main.sync {
        // draw line
        self.jointView.bodyPoints = predictedPoints // has the information about the points
        
        // end of measure
        self.👨‍🔧.🎬🤚()
        self.isInferencing = false
        
        if #available(iOS 12.0, *) {
          os_signpost(.end, log: refreshLog, name: "PoseEstimation")
        }
      }
      /* =================================================================== */
    } else {
      // end of measure
      self.👨‍🔧.🎬🤚()
      self.isInferencing = false
      
      if #available(iOS 12.0, *) {
        os_signpost(.end, log: refreshLog, name: "PoseEstimation")
      }
    }
  }
}


// Source: https://github.com/owingst/SwiftUIScanner/blob/master/SwiftUIScanner/
//extension JointViewController: UIViewControllerRepresentable {
//
//  public typealias UIViewControllerType = JointViewController
//
//  func makeUIViewController(context: UIViewControllerRepresentableContext<JointViewController>) -> JointViewController {
//    return JointViewController(jointView: )
//  }
//
//  func updateUIViewController(_ uiViewController: JointViewController, context: UIViewControllerRepresentableContext<JointViewController>) {
//  }
//}

// Source: https://dev.to/kevinmaarek/working-with-your-uiviewcontroller-and-swiftui-2917
struct JointViewControllerWrapper: UIViewControllerRepresentable {
  
  var jointView: DrawingJointView!
  
  init (jointView: DrawingJointView!) {
    self.jointView = jointView
  }
  
  public typealias UIViewControllerType = JointViewController
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<JointViewControllerWrapper>) -> JointViewControllerWrapper.UIViewControllerType {
    return JointViewController(jointView: self.jointView)
  }
  
  func updateUIViewController(_ uiViewController: JointViewControllerWrapper.UIViewControllerType, context: UIViewControllerRepresentableContext<JointViewControllerWrapper>) {
  }
}
