//
//  WorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var workoutsViewModel: WorkoutsViewModel
    @ObservedObject var exercisesViewModel: ExercisesViewModel
    @ObservedObject var recommendationViewModel: RecommendationViewModel
    
    init(workoutsViewModel: WorkoutsViewModel,
         exercisesViewModel: ExercisesViewModel,
         recommendationViewModel: RecommendationViewModel) {
        self.workoutsViewModel = workoutsViewModel
        self.exercisesViewModel = exercisesViewModel
        self.recommendationViewModel = recommendationViewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                TodayView(workoutsViewModel: self.workoutsViewModel,
                          exercisesViewModel: self.exercisesViewModel,
                          recommendationViewModel: self.recommendationViewModel)
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
        WorkoutView(workoutsViewModel: WorkoutsViewModel(workoutsParser: WorkoutsParser()),
                    exercisesViewModel: ExercisesViewModel(exercisesParser: ExercisesParser()),
                    recommendationViewModel: RecommendationViewModel(recommendationParser: RecommendationParser()))
    }
}
