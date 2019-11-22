//
//  SetDetailView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

class TimerStruct: ObservableObject {
  var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}

class DrawingJointViewStruct: ObservableObject {
  var jointView: DrawingJointView! = DrawingJointView()
}

struct SetDetailView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var jointViewStruct: DrawingJointViewStruct
  @State private var isCameraMode: Bool = false
  @State private var setCounter: Int = 0
  
  @State var timeRemaining = -1
  var timer = TimerStruct()
  var restTime: Int
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, restTime: Int) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    self.jointViewStruct = DrawingJointViewStruct()
    self.restTime = restTime
  }
  
  var body: some View {
    VStack {
      if (timeRemaining == -1 && self.setCounter < self.workoutObserver.workout.sets.count - 1) {
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
              }
              .padding(.top, 50)
              
              Spacer()
              
              HStack {
                Button(action: {
                  self.jointViewStruct.jointView.printData(label: 1)
                }) {
                  VStack {
                    HStack {
                      VStack {
                        Text(verbatim: "Peak")
                          .font(.headline)
                          .foregroundColor(Color(UIColor.white))
                          .padding(.horizontal, 20)
                          .padding(.vertical, 10)
                          .foregroundColor(.primary)
                          .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
                          .cornerRadius(30)
                          .padding(.bottom, 50)
                      }
                    }
                  }
                }
                
                Button(action: {
                  self.jointViewStruct.jointView.printData(label: -1)
                }) {
                  VStack {
                    HStack {
                      VStack {
                        Text(verbatim: "Trough")
                          .font(.headline)
                          .foregroundColor(Color(UIColor.white))
                          .padding(.horizontal, 20)
                          .padding(.vertical, 10)
                          .foregroundColor(.primary)
                          .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemRed), Color(UIColor.systemOrange)]), startPoint: .top, endPoint: .bottom))
                          .cornerRadius(30)
                          .padding(.bottom, 50)
                      }
                    }
                  }
                }
              }
            }
          }
        } else {
          HStack {
            Text(verbatim: self.workoutObserver.workout.sets[setCounter].exercise.name)
              .font(.system(size: 40))
              .fontWeight(.semibold)
              .foregroundColor(.primary)
              .padding(.all, 20)
            
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
          }
          .padding(.top, 50)
          
          Spacer()
          
          Text(verbatim: "\(self.workoutObserver.workout.sets[setCounter].reps ?? 0)")
            .font(.system(size: 100))
            .fontWeight(.bold)
            .foregroundColor(.gray)
          
          Spacer()
          
          Button(action: {
            self.timeRemaining = self.restTime
            self.timer.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
          }) {
            GeometryReader { geometry in
              VStack {
                HStack {
                  VStack {
                    Text(verbatim: "Done")
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
          }
          .padding(.horizontal, 50)
        }
      } else if (timeRemaining >= 0 && self.setCounter < self.workoutObserver.workout.sets.count - 1) {
        Text(verbatim: "Rest Timer")
          .font(.system(size: 40))
          .fontWeight(.semibold)
          .foregroundColor(.primary)
          .padding(.all, 20)
          .padding(.top, 50)
        
        Spacer()
        
        Text(verbatim: "\(timeRemaining)")
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
          self.timeRemaining = -1
          self.setCounter = self.setCounter + 1
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
            
            Text(verbatim: "Next: \(self.workoutObserver.workout.sets[setCounter + 1].exercise.name)")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 10)
              .padding(.bottom, 50)
          }
        }
      } else {
        HStack {
          Text(verbatim: self.workoutObserver.workout.sets[setCounter].exercise.name)
            .font(.system(size: 40))
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .padding(.all, 20)
          
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
        }
        .padding(.top, 50)
        
        Spacer()
        
        Text(verbatim: "\(self.workoutObserver.workout.sets[setCounter].reps ?? 0)")
          .font(.system(size: 100))
          .fontWeight(.bold)
          .foregroundColor(.gray)
        
        Spacer()
        
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
          GeometryReader { geometry in
            VStack {
              HStack {
                VStack {
                  Text(verbatim: "Finish")
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
        }
      }
    }
  }
}

//struct SetDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    SetDetailView(exercisesObserver: ExercisesObserver(),
//                  workoutObserver: WorkoutObserver())
//  }
//}
