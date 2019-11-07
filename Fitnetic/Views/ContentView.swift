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
  @ObservedObject var graphicObserver: GraphicObserver
  
  init() {
    self.userObserver = UserObserver()
    self.workoutsObserver = WorkoutsObserver()
    self.exercisesObserver = ExercisesObserver()
    self.workoutObserver = WorkoutObserver()
    self.analyticsObserver = AnalyticsObserver()
    self.graphicObserver = GraphicObserver()
  }
  
  var body: some View {
    TabView(selection: $selectedView) {
      WorkoutView(workoutsObserver: self.workoutsObserver,
                  exercisesObserver: self.exercisesObserver,
                  workoutObserver: self.workoutObserver)
        .tabItem {
          Image(systemName: "square.fill")
          Text("Workout")
      }.tag(0)
      AnalyticsView(analyticsObserver: self.analyticsObserver,
                    graphicObserver: self.graphicObserver)
        .tabItem {
          Image(systemName: "square.fill")
          Text("Analytics")
      }.tag(1)
      ProfileView(userObserver: self.userObserver)
        .tabItem {
          Image(systemName: "square.fill")
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
