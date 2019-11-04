//
//  WorkoutsParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

class WorkoutsParser {
  var userID: String
  var workoutsURL: String
  var workouts: [Workout]?

  init() {
    self.userID = "5dbf3ac810fe5000041aef80"
    self.workoutsURL = "https://fitnetic-api.herokuapp.com/workouts/" + self.userID
    self.getWorkoutsData()
  }

  func getWorkoutsData() {
    let task = URLSession.shared.dataTask(with: URL(string: self.workoutsURL)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }

        guard let workouts = try? JSONDecoder().decode([Workout].self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
        }
        
        self.workouts = workouts
    }
    
    task.resume()
  }

  func getWorkouts() -> [Workout]? {
    return self.workouts
  }
    
}
