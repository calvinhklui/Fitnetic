//
//  WorkoutListView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/5/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WorkoutListView: View {
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  
  init(workoutsObserver: WorkoutsObserver, exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver) {
    self.workoutsObserver = workoutsObserver
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
  }
  
  var body: some View {
    ScrollView {
      ForEach((0 ..< self.workoutsObserver.workouts.count), id:\.self) { i in
        NavigationLink(destination: TodayDetailView(exercisesObserver: self.exercisesObserver,
                                                    workoutObserver: self.workoutObserver,
                                                    workout: self.workoutsObserver.workouts[i])) {
          WorkoutRowView(workout: self.workoutsObserver.workouts[i])
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .padding(.top, 20)
      }
    }
    .navigationBarTitle(Text("History"))
  }
}

struct WorkoutListView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutListView(workoutsObserver: WorkoutsObserver(),
                    exercisesObserver: ExercisesObserver(),
                    workoutObserver: WorkoutObserver())
  }
}
