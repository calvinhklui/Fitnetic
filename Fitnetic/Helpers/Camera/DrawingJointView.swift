// Source: https://github.com/tucan9389/PoseEstimation-CoreML

import UIKit

class DrawingJointView: UIView {
  
  static let threshold = 0.2
  
  private var keypointLabelBGViews: [UIView] = []
  
  public var bodyPoints: [PredictedPoint?] = [] {
    didSet {
      self.setNeedsDisplay()
      
      var bodyDetected = true
      
      for bodyPoint in bodyPoints {
        if let bp = bodyPoint, bp.maxConfidence < DrawingJointView.threshold {
          bodyDetected = false
        }
      }
      
//      printData()
      
      if bodyDetected {
        self.drawKeypoints(with: bodyPoints)
      } else {
        self.clearKeypoints(with: bodyPoints)
      }
      
      self.processRep()
    }
  }
  
  // for rep tracking
  var peakPoints: [Float] = [0, 0, 0, 0.12499999999999997, -0.027777777777777846, 0.16666666666666666, -0.013888888888888895, 0.2777777777777778, -0.055555555555555636, 0.36111111111111116, 0.02777777777777768, 0.16666666666666666, 0.04166666666666663, 0.2777777777777778, 0.04166666666666663, 0.375, -0.041666666666666685, 0.375, -0.041666666666666685, 0.5, -0.041666666666666685, 0.625, 0.04166666666666663, 0.375, 0.08333333333333326, 0.5, 0.08333333333333326, 0.625]
  var troughPoints: [Float] = [0, 0, 0, 0.11458333333333331, -0.08333333333333337, 0.11458333333333331, -0.12500000000000006, 0.15625, -0.11111111111111122, 0.15625, 0.08333333333333326, 0.11458333333333331, 0.125, 0.1701388888888889, 0.125, 0.22569444444444448, -0.041666666666666685, 0.28124999999999994, -0.08333333333333337, 0.3229166666666667, -0.08333333333333337, 0.40624999999999994, 0.04166666666666663, 0.28124999999999994, 0.0972222222222221, 0.3229166666666667, 0.08333333333333326, 0.40624999999999994]
  var currentRep = 0
  var targetReps = 10
  var startedSet = false
  var nextGoal = 1
  var repThreshold: Float = 0.1
  
  public func convertDataToArray() -> [Float] {
    var outputArr: [Float] = []
    
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    
    var counter = 0
    for bodyPoint in bodyPoints {
      if let bp = bodyPoint {
        if counter == 0 {
          offsetX = bp.maxPoint.x
          offsetY = bp.maxPoint.y
        }
        
        outputArr.append(Float(bp.maxPoint.x - offsetX))
        outputArr.append(Float(bp.maxPoint.y - offsetY))
      } else {
        outputArr.append(-1)
        outputArr.append(-1)
      }
      
      counter = counter + 1
    }
    
    return outputArr
  }
  
  // Source: https://github.com/evanmoss/SwiftSim/blob/master/EMSimilarity.swift
  private func dot(A: [Float], B: [Float]) -> Float {
      var x: Float = 0
      for i in 0...A.count-1 {
          x += A[i] * B[i]
      }
      return x
  }
  
  // Source: https://github.com/evanmoss/SwiftSim/blob/master/EMSimilarity.swift
  private func magnitude(A: [Float]) -> Float {
      var x: Float = 0
      for elt in A {
          x += elt * elt
      }
      return sqrt(x)
  }
  
  // Source: https://github.com/evanmoss/SwiftSim/blob/master/EMSimilarity.swift
  public func cosineSimilarity(_ A: [Float], _ B: [Float]) -> Float {
      return dot(A: A, B: B) / (magnitude(A: A) * magnitude(A: B))
  }
  
  public func printData(label: Int = 0) {
    var outputArr: [String] = []
    
    for bodyPoint in bodyPoints {
      if let bp = bodyPoint {
        outputArr.append("\(bp.maxPoint.x), \(bp.maxPoint.y), \(bp.maxConfidence)")
      } else {
        outputArr.append("-1, -1, -1")
      }
    }
    
    outputArr.append("\(label)")
    
    print(outputArr)
  }
  
  private func processRep() {
    let points = self.convertDataToArray()
    
    let peakCosineSimilarity = self.cosineSimilarity(points, peakPoints)
    let troughCosineSimilarity = self.cosineSimilarity(points, troughPoints)
    
    if (nextGoal == 1 && peakCosineSimilarity < 1 - repThreshold) {
      if (startedSet == false) {
        startedSet = true
      } else {
        currentRep += 1
        nextGoal = 0
      }
    } else if (nextGoal == 0 && troughCosineSimilarity < 1 - repThreshold) {
      currentRep += 1
      nextGoal = 1
    }
  }
  
  private func setUpLabels(with keypointsCount: Int) {
    self.subviews.forEach({ $0.removeFromSuperview() })
    
    let pointSize = CGSize(width: 10, height: 10)
    keypointLabelBGViews = (0..<keypointsCount).map { index in
      let color = PoseEstimationForMobileConstant.colors[index%PoseEstimationForMobileConstant.colors.count]
      let view = UIView(frame: CGRect(x: 0, y: 0, width: pointSize.width, height: pointSize.height))
      view.backgroundColor = color
      view.clipsToBounds = false
      view.layer.cornerRadius = 5
      view.layer.borderColor = UIColor.black.cgColor
      view.layer.borderWidth = 1.4
      
      self.addSubview(view)
      return view
    }
  }
  
  override func draw(_ rect: CGRect) {
    if let ctx = UIGraphicsGetCurrentContext() {
      
      ctx.clear(rect);
      
      let size = self.bounds.size
      
      var bodyDetected = true
      
      for bodyPoint in bodyPoints {
        if let bp = bodyPoint, bp.maxConfidence < DrawingJointView.threshold {
          bodyDetected = false
        }
      }
      
      if bodyDetected {
        let color = PoseEstimationForMobileConstant.jointLineColor.cgColor
        if PoseEstimationForMobileConstant.pointLabels.count == bodyPoints.count {
          let _ = PoseEstimationForMobileConstant.connectedPointIndexPairs.map { pIndex1, pIndex2 in
            if let bp1 = self.bodyPoints[pIndex1], let bp2 = self.bodyPoints[pIndex2] {
              let p1 = bp1.maxPoint
              let p2 = bp2.maxPoint
              let point1 = CGPoint(x: p1.x * size.width, y: p1.y*size.height)
              let point2 = CGPoint(x: p2.x * size.width, y: p2.y*size.height)
              drawLine(ctx: ctx, from: point1, to: point2, color: color)
            }
          }
        }
      }
    }
  }
  
  private func drawLine(ctx: CGContext, from p1: CGPoint, to p2: CGPoint, color: CGColor) {
    ctx.setStrokeColor(color)
    ctx.setLineWidth(3.0)
    
    ctx.move(to: p1)
    ctx.addLine(to: p2)
    
    ctx.strokePath();
  }
  
  private func drawKeypoints(with n_kpoints: [PredictedPoint?]) {
    let imageFrame = keypointLabelBGViews.first?.superview?.frame ?? .zero
    
    let minAlpha: CGFloat = 0.4
    let maxAlpha: CGFloat = 1.0
    let maxC: Double = 0.6
    let minC: Double = 0.1
    
    if n_kpoints.count != keypointLabelBGViews.count {
      setUpLabels(with: n_kpoints.count)
    }
    
    for (index, kp) in n_kpoints.enumerated() {
      if let n_kp = kp {
        let x = n_kp.maxPoint.x * imageFrame.width
        let y = n_kp.maxPoint.y * imageFrame.height
        keypointLabelBGViews[index].center = CGPoint(x: x, y: y)
        let cRate = (n_kp.maxConfidence - minC)/(maxC - minC)
        keypointLabelBGViews[index].alpha = (maxAlpha - minAlpha) * CGFloat(cRate) + minAlpha
      } else {
        keypointLabelBGViews[index].center = CGPoint(x: -4000, y: -4000)
        keypointLabelBGViews[index].alpha = minAlpha
      }
    }
  }
  
  private func clearKeypoints(with n_kpoints: [PredictedPoint?]) {
    if n_kpoints.count != keypointLabelBGViews.count {
      setUpLabels(with: n_kpoints.count)
    }
    
    for (index, _) in n_kpoints.enumerated() {
        keypointLabelBGViews[index].center = CGPoint(x: -4000, y: -4000)
        keypointLabelBGViews[index].alpha = 0
    }
  }
}

// MARK: - Constant for edvardHua/PoseEstimationForMobile
struct PoseEstimationForMobileConstant {
  static let pointLabels = [
    "top",          //0
    "neck",         //1
    
    "R shoulder",   //2
    "R elbow",      //3
    "R wrist",      //4
    "L shoulder",   //5
    "L elbow",      //6
    "L wrist",      //7
    
    "R hip",        //8
    "R knee",       //9
    "R ankle",      //10
    "L hip",        //11
    "L knee",       //12
    "L ankle",      //13
  ]
  
  static let connectedPointIndexPairs: [(Int, Int)] = [
    (0, 1),     // top-neck
    
    (1, 2),     // neck-rshoulder
    (2, 3),     // rshoulder-relbow
    (3, 4),     // relbow-rwrist
    (1, 8),     // neck-rhip
    (8, 9),     // rhip-rknee
    (9, 10),    // rknee-rankle
    
    (1, 5),     // neck-lshoulder
    (5, 6),     // lshoulder-lelbow
    (6, 7),     // lelbow-lwrist
    (1, 11),    // neck-lhip
    (11, 12),   // lhip-lknee
    (12, 13),   // lknee-lankle
  ]
  
  static let jointLineColor: UIColor = UIColor.systemGray5
  
  static var colors: [UIColor] = [
    UIColor.systemBlue,
    .white,
    
    .white,
    .white,
    .white,
    
    .white,
    .white,
    .white,
    
    .white,
    .white,
    .white,
    
    .white,
    .white,
    .white,
  ]
}
