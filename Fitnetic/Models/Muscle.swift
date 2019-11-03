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
    var id = UUID()
    var name: String
    var scientificName: String
    var group: String
}
