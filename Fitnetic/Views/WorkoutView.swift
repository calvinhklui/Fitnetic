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
  @ObservedObject var analyticsObserver: AnalyticsObserver
  @ObservedObject var userObserver: UserObserver
  
  var workedOutToday: Bool
  
  @State private var showWelcome: Bool = false
  
  init(workoutsObserver: WorkoutsObserver, exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, analyticsObserver: AnalyticsObserver, userObserver: UserObserver, workedOutToday: Bool) {
    self.workoutsObserver = workoutsObserver
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    self.analyticsObserver = analyticsObserver
    self.userObserver = userObserver
    self.workedOutToday = workedOutToday
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        Spacer()
        TodayView(workoutsObserver: self.workoutsObserver,
                  exercisesObserver: self.exercisesObserver,
                  workoutObserver: self.workoutObserver,
                  userObserver: self.userObserver)
        Spacer()
        WeekView(workoutsObserver: self.workoutsObserver,
                 exercisesObserver: self.exercisesObserver,
                 workoutObserver: self.workoutObserver,
                 analyticsObserver: self.analyticsObserver)
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
        .navigationBarItems(trailing:
            VStack {
              HStack {
                VStack {
                  if (self.workoutsObserver.loading || self.exercisesObserver.loading || self.workoutObserver.loading || self.analyticsObserver.loading || self.userObserver.loading) {
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                  } else {
                    if (workedOutToday) {
                      Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color(UIColor.systemBlue))
                    } else {
                      Image(systemName: "circle")
                      .font(.system(size: 30))
                      .foregroundColor(Color(UIColor.systemBlue))
                    }
                  }
                }
              }
            }
            .padding(.top, 95)
            .padding(.bottom, 5)
        )
        .background(Color(UIColor.systemGray6))
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .onAppear(perform: {
      self.workoutsObserver.fetchData()
      self.exercisesObserver.fetchData()
      self.workoutObserver.fetchData()
      self.analyticsObserver.fetchData()
      self.userObserver.fetchData()
      self.showWelcome = UserDefaults.standard.string(forKey: "globalUserID") == nil
    })
  }
}

struct WorkoutView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutView(workoutsObserver: WorkoutsObserver(),
                exercisesObserver: ExercisesObserver(),
                workoutObserver: WorkoutObserver(),
                analyticsObserver: AnalyticsObserver(),
                userObserver: UserObserver(),
                workedOutToday: false)
  }
}
