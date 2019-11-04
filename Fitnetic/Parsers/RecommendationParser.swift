//
//  RecommendationParser.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

class RecommendationParser {
  var userID: String
  var recommendationURL: String
  var recommendation: Workout?

  init() {
    self.userID = "5dbf3ac810fe5000041aef80"
    self.recommendationURL = "https://fitnetic-api.herokuapp.com/recommendations/" + self.userID
    self.getRecommendationData()
  }

  func getRecommendationData() {
    let task = URLSession.shared.dataTask(with: URL(string: self.recommendationURL)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }

        guard let workout = try? JSONDecoder().decode(Workout.self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
        }
        
        self.recommendation = workout
    }
    task.resume()
  }
    
  func getRecommendation() -> Workout? {
    return self.recommendation
  }
}
