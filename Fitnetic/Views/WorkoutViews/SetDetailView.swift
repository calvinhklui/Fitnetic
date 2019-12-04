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
  @ObservedObject var jointView: DrawingJointView
  
  init (peakPoints: [Float], troughPoints: [Float]) {
    self.jointView = DrawingJointView(peakPoints: peakPoints, troughPoints: troughPoints)
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
  
  @State var timeRemaining = -1
  var timer = TimerStruct()
  var restTime: Int
  
  let peakPoints: [Float] = [0, 0, 0, 0.12499999999999997, -0.027777777777777846, 0.16666666666666666, -0.013888888888888895, 0.2777777777777778, -0.055555555555555636, 0.36111111111111116, 0.02777777777777768, 0.16666666666666666, 0.04166666666666663, 0.2777777777777778, 0.04166666666666663, 0.375, -0.041666666666666685, 0.375, -0.041666666666666685, 0.5, -0.041666666666666685, 0.625, 0.04166666666666663, 0.375, 0.08333333333333326, 0.5, 0.08333333333333326, 0.625]
  let troughPoints: [Float] = [0, 0, 0, 0.11458333333333331, -0.08333333333333337, 0.11458333333333331, -0.12500000000000006, 0.15625, -0.11111111111111122, 0.15625, 0.08333333333333326, 0.11458333333333331, 0.125, 0.1701388888888889, 0.125, 0.22569444444444448, -0.041666666666666685, 0.28124999999999994, -0.08333333333333337, 0.3229166666666667, -0.08333333333333337, 0.40624999999999994, 0.04166666666666663, 0.28124999999999994, 0.0972222222222221, 0.3229166666666667, 0.08333333333333326, 0.40624999999999994]
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, restTime: Int) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    self.jointViewStruct = DrawingJointViewStruct(peakPoints: peakPoints, troughPoints: troughPoints)
    self.restTime = restTime
  }
  
  private func endCurrentSet() {
    self.timeRemaining = self.restTime
    self.timer.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    self.jointViewStruct.jointView = DrawingJointView(peakPoints: peakPoints, troughPoints: troughPoints)
    self.targetReps = self.workoutObserver.workout.sets[self.setCounter + 1].reps!
    self.repsRemaining = self.targetReps
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
              .padding(.horizontal, 20)
              
              Spacer()
              
              Text(verbatim: "\(self.repsRemaining)")
                .font(.system(size: 100))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .onReceive(self.jointViewStruct.jointView.objectWillChange) { _ in
                  self.repsRemaining = self.targetReps - self.jointViewStruct.jointView.currentRep
                  if (self.repsRemaining <= 0) {
                    if (self.setCounter == self.workoutObserver.workout.sets.count - 1) {
                      self.presentationMode.wrappedValue.dismiss()
                    } else {
                      self.endCurrentSet()
                    }
                  }
                }
              
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
        } else {
          VStack {
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
      } else {
        VStack {
          Text(verbatim: "Rest Timer")
            .font(.system(size: 40))
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .padding(.all, 20)
          
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
