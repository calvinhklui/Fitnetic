//
//  SetDetailView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct SetDetailView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  @State private var setCounter: Int = 0
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
  }
  
  @ViewBuilder
  var body: some View {
    if (self.setCounter < self.workoutObserver.workout.sets.count - 1) {
      VStack {
        Text(verbatim: self.workoutObserver.workout.sets[setCounter].exercise.name)
          .font(.system(size: 40))
          .fontWeight(.semibold)
          .foregroundColor(.primary)
        .padding(.all, 20)
        
        Spacer()
        
        Text(verbatim: "\(self.workoutObserver.workout.sets[setCounter].reps ?? 0)")
          .font(.system(size: 100))
          .fontWeight(.bold)
          .foregroundColor(.gray)
        
        Spacer()
        
        Button(action: { self.setCounter = self.setCounter + 1 }) {
          VStack {
            HStack {
              VStack {
                Text(verbatim: "Done")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(.primary)
                  .padding(.bottom, 10)
                Text(verbatim: "Next: \(self.workoutObserver.workout.sets[setCounter + 1].exercise.name)")
                  .font(.caption)
                  .foregroundColor(.secondary)
                  .padding(.bottom, 50)
              }
            }
          }
        }
      }
    } else {
      VStack {
        Text(verbatim: self.workoutObserver.workout.sets[setCounter].exercise.name)
          .font(.system(size: 40))
          .fontWeight(.semibold)
          .foregroundColor(.primary)
          .padding(.all, 20)
        
        Spacer()
        
        Text(verbatim: "\(self.workoutObserver.workout.sets[setCounter].reps ?? 0)")
          .font(.system(size: 100))
          .fontWeight(.bold)
          .foregroundColor(.gray)
        
        Spacer()
        
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
          VStack {
            HStack {
              VStack {
                Text(verbatim: "Done")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(.primary)
                  .padding(.bottom, 10)
                Text(verbatim: "Last Set!")
                  .font(.caption)
                  .foregroundColor(.secondary)
                  .padding(.bottom, 50)
              }
            }
          }
        }
      }
    }
  }
}

struct SetDetailView_Previews: PreviewProvider {
  static var previews: some View {
    SetDetailView(exercisesObserver: ExercisesObserver(),
                  workoutObserver: WorkoutObserver())
  }
}
