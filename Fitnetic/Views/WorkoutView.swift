//
//  WorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WorkoutView: View {
  @State private var showWelcome: Bool = true
  
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var analyticsObserver: AnalyticsObserver
  @ObservedObject var userObserver: UserObserver
  
  init(workoutsObserver: WorkoutsObserver, exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, analyticsObserver: AnalyticsObserver, userObserver: UserObserver) {
    self.workoutsObserver = workoutsObserver
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    self.analyticsObserver = analyticsObserver
    self.userObserver = userObserver
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        Spacer()
        TodayView(workoutsObserver: self.workoutsObserver,
                  exercisesObserver: self.exercisesObserver,
                  workoutObserver: self.workoutObserver)
        Spacer()
        WeekView(analyticsObserver: self.analyticsObserver)
        Spacer()
      }.popover(
          isPresented: self.$showWelcome,
          arrowEdge: .bottom
      ) { WelcomeView(userObserver: self.userObserver,
                      workoutsObserver: self.workoutsObserver,
                      exercisesObserver: self.exercisesObserver,
                      workoutObserver: self.workoutObserver,
                      analyticsObserver: self.analyticsObserver) }
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
                workoutObserver: WorkoutObserver(),
                analyticsObserver: AnalyticsObserver(),
                userObserver: UserObserver())
  }
}
