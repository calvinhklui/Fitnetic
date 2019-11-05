//
//  WorkoutsViewModel.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class WorkoutsViewModel: ObservableObject, Identifiable {
    @Published var workouts: [Workout] = []
    private let workoutsParser: WorkoutsParser
    
    init(workoutsParser: WorkoutsParser) {
        self.workoutsParser = workoutsParser
//        self.fetchWorkouts(userID: "5dbf3ac810fe5000041aef80")
    }
    
    func fetchWorkouts(userID: String) {
        DispatchQueue.main.async {
            self.workoutsParser.getWorkoutsData(userID: userID, completionHandler: {workouts, error in
                if let workouts = workouts {
                    self.workouts = workouts
                }
            })
        }
    }
}
