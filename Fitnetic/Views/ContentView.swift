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
    
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var workoutsViewModel: WorkoutsViewModel
    @ObservedObject var exercisesViewModel: ExercisesViewModel
    @ObservedObject var recommendationViewModel: RecommendationViewModel

    init(userViewModel: UserViewModel,
         workoutsViewModel: WorkoutsViewModel,
         exercisesViewModel: ExercisesViewModel,
         recommendationViewModel: RecommendationViewModel) {
        self.userViewModel = userViewModel
        self.workoutsViewModel = workoutsViewModel
        self.exercisesViewModel = exercisesViewModel
        self.recommendationViewModel = recommendationViewModel
    }
    
    var body: some View {
        TabView(selection: $selectedView) {
            WorkoutView(workoutsViewModel: self.workoutsViewModel,
                        exercisesViewModel: self.exercisesViewModel,
                        recommendationViewModel: self.recommendationViewModel)
                .tabItem {
                    Image(systemName: "square.fill")
                    Text("Workout")
                }.tag(0)
            AnalyticsView(workoutsViewModel: self.workoutsViewModel,
                          exercisesViewModel: self.exercisesViewModel)
                .tabItem {
                    Image(systemName: "square.fill")
                    Text("Analytics")
                }.tag(1)
            ProfileView(userViewModel: self.userViewModel)
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
        ContentView(userViewModel: UserViewModel(userParser: UserParser()),
                    workoutsViewModel: WorkoutsViewModel(workoutsParser: WorkoutsParser()),
                    exercisesViewModel: ExercisesViewModel(exercisesParser: ExercisesParser()),
                    recommendationViewModel: RecommendationViewModel(recommendationParser: RecommendationParser()))
    }
}
