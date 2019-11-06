//
//  WorkoutsObserver.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

// Source: https://theswiftdev.com/2019/08/15/urlsession-and-the-combine-framework/
class WorkoutsObserver: ObservableObject {
  private var cancellable: AnyCancellable?
  private var url: String = "https://fitnetic-api.herokuapp.com/workouts?user=" + "5dbf3ac810fe5000041aef80"
  @Published var workouts: [Workout] = [Workout]() {
    didSet {
      print("Fetched \(self.workouts.count) Workouts!")
    }
  }
  
  init() {
    self.fetchData()
  }
  
  func fetchData() -> Void {
    self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.url)!)
    .map { $0.data }
    .decode(type: [Workout].self, decoder: JSONDecoder())
    .replaceError(with: [])
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .assign(to: \.workouts, on: self)
  }
}
