//
//  ExerciseRowView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct SetRowView: View {
    var set: Set
    
    var body: some View {
        HStack {
            Text(String(set.reps))
                .resizable()
                .frame(width: 50, height: 50)
            Text(set.exercise.name)
        }
    }
}

struct ExerciseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRowView(Set (
            exercise: Exercise (
                name: "Push Ups",
                muscles: [Muscle (
                    name: "Arms",
                    scientificName: "Arms"
                )]
            )
        ))
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
