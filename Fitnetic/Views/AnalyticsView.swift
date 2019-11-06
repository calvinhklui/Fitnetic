//
//  AnalyticsView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct AnalyticsView: View {
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  
  init(workoutsObserver: WorkoutsObserver, exercisesObserver: ExercisesObserver) {
    self.workoutsObserver = workoutsObserver
    self.exercisesObserver = exercisesObserver
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        Spacer()
        EmptyView()
        Spacer()
      }
      .navigationBarTitle("Analytics", displayMode: .large)
      .background(bgColor)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct AnalyticsView_Previews: PreviewProvider {
  static var previews: some View {
    AnalyticsView(workoutsObserver: WorkoutsObserver(),
                  exercisesObserver: ExercisesObserver())
  }
}
