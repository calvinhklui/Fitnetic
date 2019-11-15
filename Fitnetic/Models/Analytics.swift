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
  
  var numWorkoutsTrend: Int
  var numSetsTrend: Int
  var numMusclesHitTrend: Int

  enum CodingKeys : String, CodingKey {
    case numWorkouts
    case numDaysWorkedOut
    case numSets
    case numMusclesHit
    case workoutDatesList
    case workoutBoolList
    
    case numWorkoutsTrend
    case numSetsTrend
    case numMusclesHitTrend
  }
}
