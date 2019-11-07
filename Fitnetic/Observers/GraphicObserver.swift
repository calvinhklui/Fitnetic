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
  private var url: String = "https://fitnetic-api.herokuapp.com/heatmap?user=" + "5dbf3ac810fe5000041aef80"
  @Published var graphic: Graphic = dummyGraphic {
    didSet {
      print("Fetched Graphic!")
    }
  }
  
  init() {
    self.fetchData()
  }
  
  func fetchData() -> Void {
    self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.url)!)
    .map { $0.data }
    .decode(type: Graphic.self, decoder: JSONDecoder())
    .replaceError(with: dummyGraphic)
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .assign(to: \.graphic, on: self)
  }
}

let dummyGraphic = Graphic(
  id: "abcdefg",
  // image: UIImage(systemName: "plus")
)
