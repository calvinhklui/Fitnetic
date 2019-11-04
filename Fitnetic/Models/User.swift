//
//  User.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct User: Codable {
  var id: String
  var username: String
  var firstName: String
  var lastName: String
  var dateOfBirth: Date
  var gender: String
  var goal: String
    
  enum CodingKeys : String, CodingKey {
    case id = "_id"
    case username
    case firstName 
    case lastName
    case dateOfBirth
    case gender
    case goal
  }
}
