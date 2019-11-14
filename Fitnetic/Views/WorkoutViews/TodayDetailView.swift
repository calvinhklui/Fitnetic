//
//  TodayDetailView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct TodayDetailView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State var isPreWorkout: Bool = true
  @State private var showPopover: Bool = false
  
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  var workout: Workout
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, workout: Workout?) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    
    if let workout = workout {
      self.workout = workout  // use selected workout from history
    } else {
      self.workout = workoutObserver.workout  // use recommended workout
    }
    
    UITableView.appearance().backgroundColor = UIColor.systemBackground
  }
  
  var body: some View {
    VStack {
      Spacer()
      
      SetListView(exercisesObserver: self.exercisesObserver, workoutObserver: self.workoutObserver, workout: self.workout)
        .frame(height: 480)
      
      Spacer()
      .padding(.bottom, 10)
      
      if (self.isPreWorkout) {
        Button(action: {
          self.showPopover = true
          self.isPreWorkout = false
        }) {
          VStack {
            HStack {
              VStack {
                Text(verbatim: "Start")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(Color(UIColor.white))
              }
            }
          }
          .padding(.horizontal, 30)
          .padding(.vertical, 15)
          .foregroundColor(.primary)
          .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
          .cornerRadius(30)
        }
        .padding(.bottom, 20)
      } else {
        Button(action: {
          self.presentationMode.wrappedValue.dismiss()
          self.workoutObserver.postData()
        }) {
          VStack {
            HStack {
              VStack {
                Text(verbatim: "Save")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(Color(UIColor.white))
              }
            }
          }
          .padding(.horizontal, 30)
          .padding(.vertical, 15)
          .foregroundColor(.primary)
          .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
          .cornerRadius(30)
        }
        .padding(.bottom, 20)
        .navigationBarBackButtonHidden(true)
      }
    }
    .popover(
      isPresented: self.$showPopover,
      arrowEdge: .bottom
    ) {
      VStack {
        HStack {
          Button(action: {
            self.isPreWorkout = true
            self.showPopover = false
          }) {
            HStack {
              Text(verbatim: "Cancel")
                .foregroundColor(.red)
            }
          }
          .padding(20)
          
          Spacer()
        }
        SetDetailView(exercisesObserver: self.exercisesObserver,
                      workoutObserver: self.workoutObserver)
      }
    }
    .navigationBarTitle(Text("Today"))
    .background(Color(UIColor.systemGray6))
  }
}

struct TodayDetailView_Previews: PreviewProvider {
  static var previews: some View {
    TodayDetailView(exercisesObserver: ExercisesObserver(),
                    workoutObserver: WorkoutObserver(),
                    workout: nil)
  }
}
