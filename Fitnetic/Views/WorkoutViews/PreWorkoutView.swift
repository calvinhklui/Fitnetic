//
//  PreWorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct PreWorkoutView: View {
    @Binding var recommendation: Workout
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                List(self.recommendation.sets, id: \.reps) {workoutSet in
                    SetRowView(set: workoutSet)
                }
                .navigationBarTitle(Text("Landmarks"))
                
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PreWorkoutView_Previews: PreviewProvider {
    @State static var recommendation = WorkoutsParser().getWorkouts()![0]
    
    static var previews: some View {
        PreWorkoutView(recommendation: $recommendation)
    }
}
