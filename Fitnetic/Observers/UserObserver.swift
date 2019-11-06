//
//  UserObserver.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

// Source: https://theswiftdev.com/2019/08/15/urlsession-and-the-combine-framework/
class UserObserver: ObservableObject {
  private var cancellable: AnyCancellable?
  private var url: String = "https://fitnetic-api.herokuapp.com/users/" + "5dbf3ac810fe5000041aef80"
  @Published var user: User = dummyUser {
    didSet {
      print("Fetched User Data for \(self.user.username)!")
    }
  }
  
  init() {
    self.fetchData()
  }
  
  func fetchData() -> Void {
    self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.url)!)
    .map { $0.data }
    .decode(type: User.self, decoder: JSONDecoder())
    .replaceError(with: dummyUser)
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .assign(to: \.user, on: self)
  }
}

let dummyUser = User(
  id: "abcde123",
  username: "calvinhklui",
  firstName: "Calvin",
  lastName: "Lui",
  dateOfBirth: "N/A",
  gender: "Male",
  goal: "Gain Weight"
)
