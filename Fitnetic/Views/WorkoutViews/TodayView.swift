//
//  TodayView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/30/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct TodayView: View {
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  var todayExercises: [String] = []
  
  init(workoutsObserver: WorkoutsObserver,
       exercisesObserver: ExercisesObserver,
       workoutObserver: WorkoutObserver) {
    self.workoutsObserver = workoutsObserver
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    
    // format exercise names for display
    let workout = self.workoutObserver.workout
    for i in 0 ..< workout.sets.count {
      if (!self.todayExercises.contains(workout.sets[i].exercise.name.capitalized)) {
        self.todayExercises.append(workout.sets[i].exercise.name.capitalized)
      }
    }
    
    if (workout.sets.count > 3) {
      self.todayExercises = Array(self.todayExercises[0..<3])
    }
    
    if (workout.sets.count > 0) {
      self.todayExercises[self.todayExercises.count - 1] = self.todayExercises[self.todayExercises.count - 1] + "."
    }
  }
  
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          NavigationLink(destination: SetListView(exercisesObserver: self.exercisesObserver,
                                                  workoutObserver: self.workoutObserver,
                                                  workout: nil)) {
            VStack {
              HStack {
                VStack(alignment: .leading) {
                  Text(verbatim: "Today")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                  Text(verbatim: "\(todayExercises.joined(separator: ", "))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                }
                .layoutPriority(100)
                Spacer()
              }
              .padding(20)
            }
          }
          .cornerRadius(10)
          .overlay(RoundedRectangle(cornerRadius: 10)
          .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.6), lineWidth: 1))
          .padding(.bottom, 20)
          
          NavigationLink(destination: WorkoutListView(workoutsObserver: self.workoutsObserver,
                                                      exercisesObserver: self.exercisesObserver,
                                                      workoutObserver: self.workoutObserver)) {
            VStack {
              HStack {
                VStack(alignment: .leading) {
                  Text(verbatim: "Previous Workouts")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                  Text(verbatim: "Explore your past.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                }
                .layoutPriority(100)
                Spacer()
              }
              .padding(20)
            }
          }
          .cornerRadius(10)
          .overlay(RoundedRectangle(cornerRadius: 10)
          .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.6), lineWidth: 1))
          .padding(.bottom, 20)
        }
        .layoutPriority(100)
        Spacer()
      }
      .padding(20)
    }
    .background(Color.white)
    .onAppear(perform: workoutObserver.fetchData)
  }
}

struct TodayView_Previews: PreviewProvider {
  static var previews: some View {
    TodayView(workoutsObserver: WorkoutsObserver(),
              exercisesObserver: ExercisesObserver(),
              workoutObserver: WorkoutObserver())
  }
}
