//
//  Analytics.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct Analytics: Codable {
  var numWorkouts: Int
  var numDaysWorkedOut: Int
  var numSets: Int
  var numMusclesHit: Int
  var workoutDatesList: [String]
  var workoutBoolList: [Bool]

  enum CodingKeys : String, CodingKey {
    case numWorkouts
    case numDaysWorkedOut
    case numSets
    case numMusclesHit
    case workoutDatesList
    case workoutBoolList
  }
}
