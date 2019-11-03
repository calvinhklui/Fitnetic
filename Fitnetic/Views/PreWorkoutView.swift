//
//  PreWorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct PreWorkoutView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                List() {
                    ExerciseRowView()
                }
                Spacer()
            }
            .navigationBarTitle("Workout", displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PreWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        PreWorkoutView()
    }
}
