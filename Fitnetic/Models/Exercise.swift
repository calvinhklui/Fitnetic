//
//  Exercise.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct Exercise: Codable {
  var id: String
  var name: String
  var muscles: [Muscle]?
  
  enum CodingKeys : String, CodingKey {
    case id = "_id"
    case name
    case muscles
  }
}
