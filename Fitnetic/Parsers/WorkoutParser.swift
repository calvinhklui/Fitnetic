//
//  WorkoutParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

struct WorkoutList: Codable {
  var totalCount: Int
  var workouts: [Workout]
  
  enum CodingKeys : String, CodingKey {
    case totalCount
    case workouts = "items"
  }
}

class WorkoutListParser {
  var workoutListURL: String

  init() {
    self.workoutListURL = "https://fitnetic-api.herokuapp.com/workouts/JSON"
  }

  func getWorkoutListData(userCompletionHandler: @escaping (WorkoutList?, Error?) -> Void) {
    let WorkoutListTask = URLSession.shared.dataTask(with: URL(string: workoutListURL)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }

        guard let workoutList = try? JSONDecoder().decode(WorkoutList.self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
      }
      userCompletionHandler(workoutList, nil)
    }
    WorkoutListTask.resume()
  }
}

// This code has not passed the tests yet

// Use the code below to parse the workout list

//let parser4 = WorkoutListParser()
//parser4.getWorkoutListData(userCompletionHandler: {workoutList, error in
//  if let workoutList = workoutList {
//    for workout in workoutList.workouts {
//      print(workout.user)
//      for s in workout.workoutSets {
//        print(s.reps)
//      }
//    }
//  }
//})
