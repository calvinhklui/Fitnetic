//
//  Muscle.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct Muscle: Identifiable, Codable {
  var id: String
  var name: String

  enum CodingKeys : String, CodingKey {
    case id = "_id"
    case name
  }
}
