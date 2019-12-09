// Source: https://github.com/tucan9389/PoseEstimation-CoreML

import UIKit
import SwiftUI
import Combine
import CoreML

class DrawingJointView: UIView, ObservableObject {
  private var isDebug = false
  private var keypointLabelBGViews: [UIView] = []
  public var bodyPoints: [PredictedPoint?] = [] {
    didSet {
      self.setNeedsDisplay()
      
      var bodyDetected = true
      
      for bodyPoint in bodyPoints {
        if let bp = bodyPoint, bp.maxConfidence < 0.2 {
          bodyDetected = false
        }
      }
      
      if bodyDetected {
        self.processRepWithML()
      }
      
      if isDebug {
        if bodyDetected {
          self.drawKeypoints(with: bodyPoints)
        } else {
          self.clearKeypoints(with: bodyPoints)
        }
      }
    }
  }
  
  var exerciseName: String
  required init (exerciseName: String) {
    self.exerciseName = exerciseName
    super.init(frame: CGRect.zero)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @Published var currentRep = 0
  @Published var position = "Absent"
  @Published var positionScore = 0.00
  var startedSet = false
  var nextGoal = "Ready"
  var repThreshold: Float = 0.01
  public var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  
  private func processRepWithML() {
    let points = self.convertDataToArray()
    
    if (exerciseName == "Squats") {
      let readyModel = SquatsPeak()
      let actionModel = SquatsTrough()
      
      guard let readyOutput = try? readyModel.prediction(
        topX: points[0],
        topY: points[1],
        neckX: points[2],
        neckY: points[3],
        rShoulderX: points[4],
        rShouderY: points[5],
        rElbowX: points[6],
        rElbowY: points[7],
        rWristX: points[8],
        rWristY: points[9],
        lShoulderX: points[10],
        lShoulderY: points[11],
        lElbowX: points[12],
        lElbowY: points[13],
        lWristX: points[14],
        lWristY: points[15],
        rHipX: points[16],
        rHipY: points[17],
        rKneeX: points[18],
        rKneeY: points[19],
        rAnkleX: points[20],
        rAnkleY: points[21],
        lHipX: points[22],
        lHipY: points[23],
        lKneeX: points[24],
        lKneeY: points[25],
        lAnkleX: points[26],
        lAnkleY: points[27]
      ) else {
          fatalError("Unexpected runtime error on ReadyModel.")
      }
      guard let actionOutput = try? actionModel.prediction(
        topX: points[0],
        topY: points[1],
        neckX: points[2],
        neckY: points[3],
        rShoulderX: points[4],
        rShouderY: points[5],
        rElbowX: points[6],
        rElbowY: points[7],
        rWristX: points[8],
        rWristY: points[9],
        lShoulderX: points[10],
        lShoulderY: points[11],
        lElbowX: points[12],
        lElbowY: points[13],
        lWristX: points[14],
        lWristY: points[15],
        rHipX: points[16],
        rHipY: points[17],
        rKneeX: points[18],
        rKneeY: points[19],
        rAnkleX: points[20],
        rAnkleY: points[21],
        lHipX: points[22],
        lHipY: points[23],
        lKneeX: points[24],
        lKneeY: points[25],
        lAnkleX: points[26],
        lAnkleY: points[27]
      ) else {
          fatalError("Unexpected runtime error on ActionModel.")
      }
      
      let readyOutputClass = readyOutput.label
      let actionOutputClass = actionOutput.label
      let readyOutputScore = readyOutput.classProbability[1] ?? 0.00
      let actionOutputScore = actionOutput.classProbability[1] ?? 0.00
      
      self.countRep(Int(readyOutputClass), Int(actionOutputClass), readyOutputScore, actionOutputScore)
    } else if (exerciseName ==  "Jumping jacks") {
      let readyModel = JumpingJacksRest()
      let actionModel = JumpingJacksJump()
      
      guard let readyOutput = try? readyModel.prediction(
        topX: points[0],
        topY: points[1],
        neckX: points[2],
        neckY: points[3],
        rShoulderX: points[4],
        rShouderY: points[5],
        rElbowX: points[6],
        rElbowY: points[7],
        rWristX: points[8],
        rWristY: points[9],
        lShoulderX: points[10],
        lShoulderY: points[11],
        lElbowX: points[12],
        lElbowY: points[13],
        lWristX: points[14],
        lWristY: points[15],
        rHipX: points[16],
        rHipY: points[17],
        rKneeX: points[18],
        rKneeY: points[19],
        rAnkleX: points[20],
        rAnkleY: points[21],
        lHipX: points[22],
        lHipY: points[23],
        lKneeX: points[24],
        lKneeY: points[25],
        lAnkleX: points[26],
        lAnkleY: points[27]
      ) else {
          fatalError("Unexpected runtime error on ReadyModel.")
      }
      guard let actionOutput = try? actionModel.prediction(
        topX: points[0],
        topY: points[1],
        neckX: points[2],
        neckY: points[3],
        rShoulderX: points[4],
        rShouderY: points[5],
        rElbowX: points[6],
        rElbowY: points[7],
        rWristX: points[8],
        rWristY: points[9],
        lShoulderX: points[10],
        lShoulderY: points[11],
        lElbowX: points[12],
        lElbowY: points[13],
        lWristX: points[14],
        lWristY: points[15],
        rHipX: points[16],
        rHipY: points[17],
        rKneeX: points[18],
        rKneeY: points[19],
        rAnkleX: points[20],
        rAnkleY: points[21],
        lHipX: points[22],
        lHipY: points[23],
        lKneeX: points[24],
        lKneeY: points[25],
        lAnkleX: points[26],
        lAnkleY: points[27]
      ) else {
          fatalError("Unexpected runtime error on ActionModel.")
      }
      
      let readyOutputClass = readyOutput.label
      let actionOutputClass = actionOutput.label
      let readyOutputScore = readyOutput.classProbability[1] ?? 0.00
      let actionOutputScore = actionOutput.classProbability[1] ?? 0.00
      
      self.countRep(Int(readyOutputClass), Int(actionOutputClass), readyOutputScore, actionOutputScore)
    }
  }
  
  private func countRep(_ readyOutputClass: Int, _ actionOutputClass: Int, _ readyOutputScore: Double, _ actionOutputScore: Double) {
    if (nextGoal == "Ready" && readyOutputClass == 1) {
      if (startedSet == false) {
        startedSet = true
      } else {
        currentRep += 1
      }
      nextGoal = "Action"
      position = "Ready"
      positionScore = readyOutputScore
    } else if (nextGoal == "Action" && actionOutputClass == 1) {
      nextGoal = "Ready"
      position = "Action"
      positionScore = actionOutputScore
    } else if (readyOutputClass == 1) {
      position = "Ready"
      positionScore = readyOutputScore
    } else if (actionOutputClass == 1) {
      position = "Action"
      positionScore = actionOutputScore
    } else if (position != "Absent") {
      position = "N/A"
      positionScore = 0.00
    }
  }
  
  public func convertDataToArray() -> [Double] {
    var outputArr: [Double] = []
    
    for bodyPoint in bodyPoints {
      if let bp = bodyPoint {
        outputArr.append(Double(bp.maxPoint.x))
        outputArr.append(Double(bp.maxPoint.y))
      } else {
        outputArr.append(-1)
        outputArr.append(-1)
      }
    }
    
    return outputArr
  }
  
  public func printData(label: Int = 0) {
    var outputArr: [Float] = []
    
    for bodyPoint in bodyPoints {
      if let bp = bodyPoint {
        outputArr.append(Float(bp.maxPoint.x))
        outputArr.append(Float(bp.maxPoint.y))
      } else {
        outputArr.append(-1)
        outputArr.append(-1)
      }
    }
    
    var outputStr = ""
    for number in outputArr {
      outputStr = outputStr + "\(number),"
    }
    outputStr = outputStr + "\(label)"
    
    print(outputStr)
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
    if let ctx = UIGraphicsGetCurrentContext(), isDebug {
      
      ctx.clear(rect);
      
      let size = self.bounds.size
      
      var bodyDetected = true
      
      for bodyPoint in bodyPoints {
        if let bp = bodyPoint, bp.maxConfidence < 0.2 {
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

// Source: https://github.com/tucan9389/PoseEstimation-CoreML
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
    .green,
    
    .green,
    .green,
    .green,
    
    .green,
    .green,
    .green,
    
    .green,
    .green,
    .green,
    
    .green,
    .green,
    .green,
  ]
}
