//
//  SetDetailView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI
import AVFoundation

class TimerStruct: ObservableObject {
  var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}

class DrawingJointViewStruct: ObservableObject {
  @ObservedObject var jointView: DrawingJointView
  
  init (exerciseName: String) {
    self.jointView = DrawingJointView(exerciseName: exerciseName)
  }
}

struct SetDetailView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var jointViewStruct: DrawingJointViewStruct
  @State private var isCameraMode: Bool = false
  @State private var setCounter: Int = 0
  @State var targetReps: Int = 10
  @State var repsRemaining: Int = 10
  @State var timeFromStart: Float = 0
  @State var timePerRep: Float = 0
  @State var bodyPosition: String = "Absent"
  @State var bodyPositionScore: Double = 0.00
  
  @State var timeRemaining = -1
  var timer = TimerStruct()
  var restTime: Int
  var synthesizer = AVSpeechSynthesizer()
  var debugMode = false
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, restTime: Int) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    self.jointViewStruct = DrawingJointViewStruct(exerciseName: workoutObserver.workout.sets[0].exercise.name)
    self.restTime = restTime
  }
  
  private func endCurrentSet() {
    self.timeRemaining = self.restTime
    self.timer.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    self.jointViewStruct.jointView = DrawingJointView(exerciseName: self.workoutObserver.workout.sets[setCounter + 1].exercise.name)
    self.targetReps = self.workoutObserver.workout.sets[self.setCounter + 1].reps!
    self.repsRemaining = self.targetReps
    if (self.isCameraMode) {
     self.isCameraMode = self.workoutObserver.workout.sets[self.setCounter + 1].exercise.arEligible
    }
    self.timeFromStart = 0
    self.timePerRep = 0
  }
  
  private func startNextSet() {
    self.timeRemaining = -1
    self.setCounter = self.setCounter + 1
  }
  
  var body: some View {
    ZStack {
      if (timeRemaining == -1) {
        if (isCameraMode) {
          ZStack {
            JointViewControllerWrapper(jointView: self.jointViewStruct.jointView)
            
            VStack {
              HStack {
                Text(verbatim: self.workoutObserver.workout.sets[setCounter].exercise.name)
                  .font(.system(size: 40))
                  .fontWeight(.semibold)
                  .foregroundColor(.primary)
                  .padding(.all, 20)
              }
              .padding(.horizontal, 20)
              .padding(.top, 50)
              .padding(.bottom, 25)
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray6), Color(UIColor.clear)]), startPoint: .top, endPoint: .bottom))
              
              Spacer()
              
              if (debugMode) {
                VStack {
                  Button(action: {
                    self.jointViewStruct.jointView.printData(label: 0)
                  }) {
                    VStack {
                      HStack {
                        VStack {
                          Text(verbatim: "0")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(Color(UIColor.white))
                        }
                      }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .foregroundColor(.primary)
                    .background(LinearGradient(gradient: Gradient(colors: [.black, Color(UIColor.systemGray)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10)
                  }
                  .padding()
                    
                  Button(action: {
                    self.jointViewStruct.jointView.printData(label: 1)
                  }) {
                    VStack {
                      HStack {
                        VStack {
                          Text(verbatim: "1")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(Color(UIColor.white))
                        }
                      }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .foregroundColor(.primary)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemRed), Color(UIColor.systemOrange)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10)
                  }
                  .padding()
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
              }
              
              Spacer()
              
              HStack {
                VStack(alignment: .leading) {
                  HStack {
                    Text(verbatim: String(format: "%.1f", Double(self.timePerRep)))
                      .font(.title)
                      .fontWeight(.black)
                      .foregroundColor(.primary)
                      .onReceive(self.jointViewStruct.jointView.timer) { _ in
                        if (self.bodyPosition != "Absent") {
                          self.timeFromStart = self.timeFromStart + 0.1
                        }
                        let denominator = (self.targetReps - self.repsRemaining)
                        self.timePerRep = self.timeFromStart / Float(denominator == 0 ? 1 : denominator)
                      }
                    Image(systemName: "circle.fill")
                      .foregroundColor((3 > self.timePerRep && self.timePerRep > 0) ? .green : .red)
                  }
                  Text(verbatim: "Pace")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                  HStack {
                    Text(verbatim: "\(self.repsRemaining)")
                      .font(.system(size: 40))
                      .fontWeight(.bold)
                      .foregroundColor(.white)
                      .padding()
                      .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
                      .clipShape(Circle())
                  }
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                  HStack {
                    Text(verbatim: self.bodyPosition)
                      .font(.title)
                      .fontWeight(.black)
                      .foregroundColor(.primary)
                    Image(systemName: "circle.fill")
                      .foregroundColor((self.bodyPositionScore > 0.75 || self.bodyPosition == "Ready") ? .green : ((self.bodyPositionScore > 0.25) ? .yellow : .red))
                  }
                  Text(verbatim: "Form")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
              }
              .padding(.horizontal, 25)
              .padding(.vertical, 50)
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.clear), Color(UIColor.systemGray6)]), startPoint: .top, endPoint: .bottom))
            }
            .edgesIgnoringSafeArea(.bottom)
            
            VStack {
              HStack {
                Spacer()
                
                if (self.workoutObserver.workout.sets[setCounter].exercise.arEligible) {
                  Button(action: {
                    self.isCameraMode = false
                  }) {
                    VStack {
                      HStack {
                        VStack {
                          Image(systemName: "camera.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                        }
                      }
                    }
                  }
                  .padding(.vertical, 20)
                  .padding(.horizontal, 15)
                }
              }
              
              Spacer()
            }
          }.colorScheme(.dark)
        } else {
          ZStack {
          VStack {
            HStack {
              Text(verbatim: self.workoutObserver.workout.sets[setCounter].exercise.name)
                .font(.system(size: 40))
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .padding(.all, 20)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Text(verbatim: "\(self.repsRemaining)")
              .font(.system(size: 100))
              .fontWeight(.bold)
              .foregroundColor(.gray)
            
            Spacer()
            
            Button(action: {
              if (self.setCounter == self.workoutObserver.workout.sets.count - 1) {
                self.presentationMode.wrappedValue.dismiss()
              } else {
                self.endCurrentSet()
              }
            }) {
              GeometryReader { geometry in
                VStack {
                  HStack {
                    VStack {
                      Text(verbatim: (self.setCounter == self.workoutObserver.workout.sets.count - 1) ? "Finish" : "Done")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(Color(UIColor.white))
                    }
                  }
                }
                .frame(width: geometry.size.width)
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                .foregroundColor(.primary)
                .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
              }
              .padding(.horizontal, 50)
              .frame(height: 50)
            }
            .padding(.vertical, 50)
          }
          .offset(y: 50)
        }
          
          VStack {
            HStack {
              Spacer()
              
              if (self.workoutObserver.workout.sets[setCounter].exercise.arEligible) {
                Button(action: {
                  self.isCameraMode = true
                }) {
                  VStack {
                    HStack {
                      VStack {
                        Image(systemName: "camera.fill")
                          .font(.title)
                          .foregroundColor(.gray)
                      }
                    }
                  }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
              }
            }
            
            Spacer()
          }
        }
      } else {
        VStack {
          Text(verbatim: "Rest Timer")
            .font(.system(size: 40))
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .padding(.all, 20)
          
          Spacer()
          
          Text(verbatim: "\(self.timeRemaining)")
            .font(.system(size: 100))
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .onReceive(timer.timer) { _ in
              if self.timeRemaining > 0 {
                self.timeRemaining -= 1
              } else if self.timeRemaining == 0 {
                self.setCounter = self.setCounter + 1
                self.timeRemaining = -1
              }
          }
          
          Spacer()
          
          Button(action: {
            self.startNextSet()
          }) {
            VStack {
              GeometryReader { geometry in
                VStack {
                  HStack {
                    VStack {
                      Text(verbatim: "I'm Ready")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(Color(UIColor.white))
                    }
                  }
                }
                .frame(width: geometry.size.width)
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                .foregroundColor(.primary)
                .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
              }
              .padding(.horizontal, 50)
              .frame(height: 50)
              
              Text(verbatim: "Next: \(self.workoutObserver.workout.sets[setCounter + 1].exercise.name)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 10)
                .padding(.bottom, 50)
            }
          }
          .padding(.top, 50)
        }
        .offset(y: 50)
      }
    }
    .onReceive(self.jointViewStruct.jointView.objectWillChange) { _ in
      // counting reps
      if (self.repsRemaining != self.targetReps - self.jointViewStruct.jointView.currentRep) {
        let utterance = AVSpeechUtterance(string: "\(self.jointViewStruct.jointView.currentRep)")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        self.synthesizer.speak(utterance)
      }
      self.repsRemaining = self.targetReps - self.jointViewStruct.jointView.currentRep
      if (self.repsRemaining <= 0) {
        let utterance = AVSpeechUtterance(string: "Good job! Your pace was \(String(format: "%.1f", Double(self.timePerRep))) seconds per rep.")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        self.synthesizer.speak(utterance)
        if (self.setCounter == self.workoutObserver.workout.sets.count - 1) {
          self.presentationMode.wrappedValue.dismiss()
        } else {
          self.endCurrentSet()
        }
      }
      
      // checking form
      if (self.jointViewStruct.jointView.position == "Ready" && self.bodyPosition == "Absent") {
        let utterance = AVSpeechUtterance(string: "body detected")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        self.synthesizer.speak(utterance)
      }
        self.bodyPosition = self.jointViewStruct.jointView.position
        self.bodyPositionScore = self.jointViewStruct.jointView.positionScore
    }
    .onAppear(perform: {
      self.targetReps = self.workoutObserver.workout.sets[self.setCounter].reps!
      self.repsRemaining = self.targetReps
    })
  }
}

//struct SetDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    SetDetailView(exercisesObserver: ExercisesObserver(),
//                  workoutObserver: WorkoutObserver())
//  }
//}
