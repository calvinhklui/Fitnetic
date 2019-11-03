//
//  ExerciseRowView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct SetRowView: View {
    var set: WorkoutSet
    
    var body: some View {
        HStack {
            Text(String(set.reps))
            Text(set.exercise.name)
        }
    }
}

//struct SetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetRowView(set: nil)
//        .previewLayout(.fixed(width: 300, height: 70))
//    }
//}
