//
//  GraphicObserver.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

// Source: https://theswiftdev.com/2019/08/15/urlsession-and-the-combine-framework/
class GraphicObserver: ObservableObject {
  private var cancellable: AnyCancellable?
  private var url: String = "https://fitnetic-api.herokuapp.com/heatmap?user="
  @Published var data: Data? = nil {
    didSet {
      print("Fetched Graphic!")
    }
  }
  
  init() {
    self.fetchData()
  }
  
  func fetchData() -> Void {
    self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.url + globalUserID)!)
    .map { $0.data }
    .decode(type: Data?.self, decoder: JSONDecoder())
    .replaceError(with: nil)
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .assign(to: \.data, on: self)
  }
  
  // Source: https://dev.to/gualtierofr/remote-images-in-swiftui-49jp
  func imageFromData() -> UIImage {
    if let data = data {
      return UIImage(data: data) ?? UIImage()
    } else {
      return UIImage()
    }
  }
}

