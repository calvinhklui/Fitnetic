//
//  ExercisesParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

class ExercisesParser {
  var exercisesURL: String
  var exercises: [Exercise]?

  init() {
    self.exercisesURL = "https://fitnetic-api.herokuapp.com/exercises/"
    self.getExercisesData()
  }

  func getExercisesData() {
    let task = URLSession.shared.dataTask(with: URL(string: self.exercisesURL)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }

        guard let exercises = try? JSONDecoder().decode([Exercise].self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
        }
        
        self.exercises = exercises
    }
    
    task.resume()
  }
    
  func getExercises() -> [Exercise]? {
    return self.exercises
  }
}
