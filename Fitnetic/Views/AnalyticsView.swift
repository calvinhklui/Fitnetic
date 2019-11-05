//
//  AnalyticsView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct AnalyticsView: View {
  @ObservedObject var workoutsViewModel: WorkoutsViewModel
  @ObservedObject var exercisesViewModel: ExercisesViewModel
  @ObservedObject var exerciseObserver : ExerciseObserver
  
  init(workoutsViewModel: WorkoutsViewModel,
       exercisesViewModel: ExercisesViewModel) {
    self.workoutsViewModel = workoutsViewModel
    self.exercisesViewModel = ExercisesViewModel(exercisesParser: ExercisesParser())
    self.exerciseObserver = ExerciseObserver()
    
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        Text("hello world")
        ForEach((0 ..< self.exercisesViewModel.exercises.count), id:\.self) { index in
          Text(self.exerciseObserver.exercises[index].name)
        }
      }
      .navigationBarTitle("Analytics", displayMode: .large)
      .background(bgColor)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct AnalyticsView_Previews: PreviewProvider {
  static var previews: some View {
    AnalyticsView(workoutsViewModel: WorkoutsViewModel(workoutsParser: WorkoutsParser()),
                  exercisesViewModel: ExercisesViewModel(exercisesParser: ExercisesParser()))
  }
}
