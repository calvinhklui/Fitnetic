import UIKit
import SwiftUI
import Combine
import CoreML

class DrawingJointView: UIView, ObservableObject {
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
