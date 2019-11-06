//
//  WorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WorkoutView: View {
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  
  init(workoutsObserver: WorkoutsObserver, exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver) {
    self.workoutsObserver = workoutsObserver
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        Spacer()
        TodayView(workoutsObserver: self.workoutsObserver,
                  exercisesObserver: self.exercisesObserver,
                  workoutObserver: self.workoutObserver)
        Spacer()
      }
      .navigationBarTitle("Workout", displayMode: .large)
      .background(bgColor)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct WorkoutView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutView(workoutsObserver: WorkoutsObserver(),
                exercisesObserver: ExercisesObserver(),
                workoutObserver: WorkoutObserver())
  }
}
