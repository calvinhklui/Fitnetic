//
//  WorkoutObserver.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

// formerly RecommendationObserver
// Source: https://theswiftdev.com/2019/08/15/urlsession-and-the-combine-framework/
class WorkoutObserver: ObservableObject {
  private var cancellable: AnyCancellable?
  private var fetchURL: String = "https://fitnetic-api.herokuapp.com/recommendations/" + "5dbf3ac810fe5000041aef80"
  private var postURL: String = "https://fitnetic-api.herokuapp.com/workouts/"
  @Published var workout: Workout = dummyRecommendation {
    didSet {
      print("Set Workout! \(self.workout.id)")
    }
  }
  
  init() {
    self.fetchData()
  }
  
  func fetchData() -> Void {
    self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.fetchURL)!)
    .map { $0.data }
    .decode(type: Workout.self, decoder: JSONDecoder())
    .replaceError(with: dummyRecommendation)
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .assign(to: \.workout, on: self)
  }
  
  func postData() -> Void {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    let dateText = dateFormatter.string(from: Date())
    
    do {
      let headers = [
        "Content-Type": "application/json",
        "Accept": "/",
        "Cache-Control": "no-cache",
        "Host": "fitnetic-api.herokuapp.com",
        "Accept-Encoding": "gzip, deflate",
        "Connection": "keep-alive"
      ]
      
      let workoutDict = [
        "user": self.workout.user.id,
        "date": dateText,
        "sets": self.workout.sets.map {
          [
            "exercise": $0.exercise.id,
            "reps": $0.reps as Any,
            "time": $0.time as Any,
            "difficulty": $0.difficulty
          ]
        }
        ] as [String : Any]
      
      let jsonData = try JSONSerialization.data(withJSONObject: workoutDict, options: .prettyPrinted)
    
      var request = URLRequest(url: URL(string: self.postURL)!)
      request.httpMethod = "POST"
      request.allHTTPHeaderFields = headers
      request.httpBody = jsonData as Data
      
      self.cancellable = URLSession.shared.dataTaskPublisher(for: request as URLRequest)
      .map { $0.data }
      .decode(type: Workout.self, decoder: JSONDecoder())
      .replaceError(with: dummyRecommendation)
      .eraseToAnyPublisher()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { workout in
        print("Posted Workout! \(workout.id)")
      })
    } catch { print("Failed to Post Workout!") }
  }
  
  func setWorkout(_ workout: Workout) -> Void {
    self.workout = workout
  }
}

let dummyRecommendation = Workout(
  id: "abcde123",
  user: dummyUser,
  date: "11/05/2019",
  sets: []
)
