//
//  Analytics.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI

struct Analytics: Identifiable, Codable {
  var id: String

  enum CodingKeys : String, CodingKey {
    case id = "_id"
  }
}
