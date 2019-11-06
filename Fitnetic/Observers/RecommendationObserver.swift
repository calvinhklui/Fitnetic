//
//  RecommendationObserver.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

// Source: https://theswiftdev.com/2019/08/15/urlsession-and-the-combine-framework/
class RecommendationObserver: ObservableObject {
  private var cancellable: AnyCancellable?
  private var url: String = "https://fitnetic-api.herokuapp.com/recommendations/" + "5dbf3ac810fe5000041aef80"
  @Published var recommendation: Workout = dummyRecommendation {
    didSet {
      print("Fetched Recommendation for \(self.recommendation.user.username)!")
    }
  }
  
  init() {
    self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.url)!)
      .map { $0.data }
      .decode(type: Workout.self, decoder: JSONDecoder())
      .replaceError(with: dummyRecommendation)
      .eraseToAnyPublisher()
      .receive(on: DispatchQueue.main)
      .assign(to: \.recommendation, on: self)
  }
}

let dummyRecommendation = Workout(
  id: "abcde123",
  user: dummyUser,
  date: "11/05/2019",
  sets: []
)
