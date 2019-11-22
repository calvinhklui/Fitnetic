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
  @ObservedObject var userObserver: UserObserver
  var todayExercises: [String] = []
  
  init(workoutsObserver: WorkoutsObserver,
       exercisesObserver: ExercisesObserver,
       workoutObserver: WorkoutObserver,
       userObserver: UserObserver) {
    self.workoutsObserver = workoutsObserver
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    self.userObserver = userObserver
    
    // format exercise names for display
    let workout = workoutObserver.workout
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
          Text(verbatim: "Today")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
          
          Text(verbatim: "Start your workout now.")
            .font(.headline)
            .foregroundColor(Color(UIColor.systemGray2))
          
          Divider()
            .padding(.top, -5)
            .padding(.bottom, 10)
          
          NavigationLink(destination: TodayDetailView(exercisesObserver: self.exercisesObserver,
                                                      workoutObserver: self.workoutObserver,
                                                      workout: self.workoutObserver.workout)) {
                                                        VStack {
                                                          HStack {
                                                            VStack(alignment: .leading) {
                                                              Text(verbatim: "Recommended")
                                                                .font(.title)
                                                                .fontWeight(.black)
                                                                .foregroundColor(Color(UIColor.white))
                                                                .padding(.bottom, 5)
                                                              Text(verbatim: "\(todayExercises.joined(separator: ", "))")
                                                                .font(.caption)
                                                                .fontWeight(.bold)
                                                                .foregroundColor(Color(hex: "888888"))
                                                                .lineLimit(3)
                                                            }
                                                            .layoutPriority(100)
                                                            Spacer()
                                                          }
                                                        }
          }
          .padding(20)
          .background(
            Image("recommendedFaded")
              .resizable()
              .scaledToFill()
          )
            .cornerRadius(10)
            .padding(.bottom, 15)
          
          NavigationLink(destination: WorkoutListView(workoutsObserver: self.workoutsObserver,
                                                      exercisesObserver: self.exercisesObserver,
                                                      workoutObserver: self.workoutObserver)) {
                                                        VStack {
                                                          HStack {
                                                            VStack(alignment: .leading) {
                                                              Text(verbatim: "History")
                                                                .font(.title)
                                                                .fontWeight(.black)
                                                                .foregroundColor(Color(UIColor.white))
                                                                .padding(.bottom, 5)
                                                              Text(verbatim: "Explore your past workouts.")
                                                                .font(.caption)
                                                                .fontWeight(.bold)
                                                                .foregroundColor(Color(hex: "888888"))
                                                                .lineLimit(3)
                                                            }
                                                            .layoutPriority(100)
                                                            Spacer()
                                                          }
                                                        }
          }
          .padding(20)
          .background(
            Image("historyFaded")
              .resizable()
              .scaledToFill()
          )
            .cornerRadius(10)
            .padding(.bottom, 15)
        }
        .layoutPriority(100)
        Spacer()
      }
      .padding(20)
    }
    .background(Color(UIColor.systemBackground))
  }
}

struct TodayView_Previews: PreviewProvider {
  static var previews: some View {
    TodayView(workoutsObserver: WorkoutsObserver(),
              exercisesObserver: ExercisesObserver(),
              workoutObserver: WorkoutObserver(),
              userObserver: UserObserver())
  }
}
