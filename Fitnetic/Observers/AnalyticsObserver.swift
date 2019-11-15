//
//  AnalyticsObserver.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SVGKit

// Source: https://theswiftdev.com/2019/08/15/urlsession-and-the-combine-framework/
class AnalyticsObserver: ObservableObject {
  private var cancellable: AnyCancellable?
  private var url: String = "https://fitnetic-api.herokuapp.com/analytics/summary/"
  private var urlSVG: String = "https://fitnetic-api.herokuapp.com/heatmap/"
  @Published var analytics: Analytics = dummyAnalytics
  @Published var heatmap: UIImage?
  
  init() {
    self.fetchData()
  }
  
  func fetchData() -> Void {
    self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.url + globalUserID)!)
    .map { $0.data }
    .decode(type: Analytics.self, decoder: JSONDecoder())
    .replaceError(with: dummyAnalytics)
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .assign(to: \.analytics, on: self)
  }
  
  func fetchSVG() -> Void {
    self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.urlSVG + globalUserID)!)
    .map { $0.data }
    .replaceError(with: Data())
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .sink(receiveValue: { data in
      self.heatmap = SVGKImage(data: data).uiImage
    })
  }
}

let dummyAnalytics = Analytics(
  numWorkouts: 0,
  numDaysWorkedOut: 0,
  numSets: 0,
  numMusclesHit: 0,
  workoutDatesList: [],
  workoutBoolList: []
)
