//
//  Workout.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct Workout: Codable {
    var id: String
    var user: User
    var date: String
    var sets: [WorkoutSet]
    
    enum CodingKeys : String, CodingKey {
      case id = "_id"
      case user
      case date
      case sets
    }
}
