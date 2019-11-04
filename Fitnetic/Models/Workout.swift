//
//  Workout.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct Workout: Identifiable, Codable {
    var id = UUID()
    var user: User
    var date: Date
    var sets: [WorkoutSet]
}
