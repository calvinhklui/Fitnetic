//
//  ExerciseParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

struct ExerciseList: Codable {
  var totalCount: Int
  var exercises: [Exercise]
  
  enum CodingKeys : String, CodingKey {
    case totalCount
    case exercises = "items"
  }
}

class ExerciseListParser {
  var exerciseListURL: String

  init() {
    self.exerciseListURL = "https://fitnetic-api.herokuapp.com/exercises/JSON"
  }

  func getExerciseListData(userCompletionHandler: @escaping (ExerciseList?, Error?) -> Void) {
    let ExerciseListTask = URLSession.shared.dataTask(with: URL(string: exerciseListURL)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }

        guard let exerciseList = try? JSONDecoder().decode(ExerciseList.self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
      }
      userCompletionHandler(exerciseList, nil)
    }
    ExerciseListTask.resume()
  }
}

// Use the code below to get a full list of exercises and a list of muscles corresponding to that exercise

//let parser3 = ExerciseListParser()
//parser3.getExerciseListData(userCompletionHandler: {exerciseList, error in
//  if let exerciseList = exerciseList {
//    for exercise in exerciseList.exercises {
//      print(exercise.name)
//      for muscle in exercise.muscles {
//        print(muscle.name)
//      }
//    }
//  }
//})
