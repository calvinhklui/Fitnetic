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
      
      printData()
      
      if bodyDetected {
        self.drawKeypoints(with: bodyPoints)
      } else {
        self.clearKeypoints(with: bodyPoints)
      }
    }
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
