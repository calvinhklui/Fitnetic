//
//  Set.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct WorkoutSet: Codable, Identifiable {
  var id = UUID()
  var exercise: Exercise
  var reps: Int?
  var time: Float?
  var difficulty: Int
  
  enum CodingKeys : String, CodingKey {
    case exercise
    case reps
    case time
    case difficulty
  }
}
