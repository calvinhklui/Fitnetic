//
//  ExercisesViewModel.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ExercisesViewModel: ObservableObject, Identifiable {
    @Published var exercises: [Exercise]?
    private let exercisesParser: ExercisesParser
    
    init(exercisesParser: ExercisesParser) {
        self.exercisesParser = exercisesParser
        self.fetchExercises()
    }
    
    func fetchExercises() {
        DispatchQueue.main.async {
            self.exercisesParser.getExercisesData(completionHandler: {exercises, error in
                if let exercises = exercises {
                    self.exercises = exercises
                }
            })
        }
    }
}
