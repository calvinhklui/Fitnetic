//
//  ExercisesObserver.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

// Source: https://theswiftdev.com/2019/08/15/urlsession-and-the-combine-framework/
class ExercisesObserver: ObservableObject {
  private var cancellable: AnyCancellable?
  private var url: String = "https://fitnetic-api.herokuapp.com/exercises/"
  @Published var exercises: [Exercise] = [Exercise]()
  
  init() {
    self.fetchData()
  }
  
  func fetchData() -> Void {
    self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.url)!)
    .map { $0.data }
    .decode(type: [Exercise].self, decoder: JSONDecoder())
    .replaceError(with: [])
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .assign(to: \.exercises, on: self)
  }
}
