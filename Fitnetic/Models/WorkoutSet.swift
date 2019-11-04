//
//  Set.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct WorkoutSet: Codable {
    var exercise: Exercise
    var reps: Int
    var time: Int
    var difficulty: Int
}

let workoutSets = [
    WorkoutSet(
        exercise: Exercise(
            id: "blah",
            name: "Push Ups"
        ),
        reps: 10,
        time: 10,
        difficulty: 0
    )
]
