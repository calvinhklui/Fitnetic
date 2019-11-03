//
//  Set.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct Set: Codable {
    var exercise: Exercise
    var reps: Int
    var time: Float
    var difficulty: Int
}
