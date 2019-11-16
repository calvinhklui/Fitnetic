//
//  ContentView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var selectedView: Int = 0
  
  @ObservedObject var userObserver: UserObserver
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var analyticsObserver: AnalyticsObserver
  
  init() {
    self.userObserver = UserObserver()
    self.workoutsObserver = WorkoutsObserver()
    self.exercisesObserver = ExercisesObserver()
    self.workoutObserver = WorkoutObserver()
    self.analyticsObserver = AnalyticsObserver()
    
    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.systemBlue
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
  }
  
  func getWorkedOutToday() -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let todayStringFormatted = dateFormatter.string(from: Date())
    let didWorkoutDatesListIndices = self.analyticsObserver.analytics.workoutDatesList.indices.filter { self.analyticsObserver.analytics.workoutBoolList[$0] }
    
    for i in didWorkoutDatesListIndices {
      if (self.analyticsObserver.analytics.workoutDatesList[i] == todayStringFormatted) {
        return true
      }
    }
    return false
  }
  
  var body: some View {
    TabView(selection: $selectedView) {
      WorkoutView(workoutsObserver: self.workoutsObserver,
                  exercisesObserver: self.exercisesObserver,
                  workoutObserver: self.workoutObserver,
                  analyticsObserver: self.analyticsObserver,
                  userObserver: self.userObserver,
                  workedOutToday: self.getWorkedOutToday())
        .tabItem {
          Image(systemName: "timer")
          Text("Workout")
      }.tag(0)
      AnalyticsView(workoutsObserver: self.workoutsObserver,
                    analyticsObserver: self.analyticsObserver,
                    workedOutToday: self.getWorkedOutToday())
        .tabItem {
          Image(systemName: "calendar")
          Text("Record")
      }.tag(1)
      ProfileView(userObserver: self.userObserver)
        .tabItem {
          Image(systemName: "person")
          Text("Profile")
      }.tag(2)
    }
    .edgesIgnoringSafeArea(.top)
    .statusBar(hidden: false)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
