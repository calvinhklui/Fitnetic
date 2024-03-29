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
  private var fetchURL: String = "https://fitnetic-api.herokuapp.com/users/"
  private var postURL: String = "https://fitnetic-api.herokuapp.com/users/"
  @Published var user: User = dummyUser
  @Published var loading: Bool = false
  
  init() {
    self.fetchData()
  }
  
  func fetchData() -> Void {
    if let globalUserID = UserDefaults.standard.string(forKey: "globalUserID") {
      self.loading = true
      self.cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: self.fetchURL + globalUserID)!)
      .map { $0.data }
      .decode(type: User.self, decoder: JSONDecoder())
      .replaceError(with: dummyUser)
      .eraseToAnyPublisher()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { user in
        self.user = user
        UserDefaults.standard.set(user.id, forKey: "globalUserID")
        self.loading = false
      })
    }
  }
  
  func postData(completion: @escaping (_ success: Bool) -> Void) -> Void {
    self.loading = true
    do {
      let headers = [
        "Content-Type": "application/json",
        "Accept": "/",
        "Cache-Control": "no-cache",
        "Host": "fitnetic-api.herokuapp.com",
        "Accept-Encoding": "gzip, deflate",
        "Connection": "keep-alive"
      ]
      
      let userDict = [
        "username": self.user.username,
        "firstName": self.user.firstName,
        "lastName": self.user.lastName,
        "dateOfBirth": self.user.dateOfBirth,
        "gender": self.user.gender,
        "goal": self.user.goal
      ] as [String : Any]
      
      let jsonData = try JSONSerialization.data(withJSONObject: userDict, options: .prettyPrinted)
    
      var request = URLRequest(url: URL(string: self.postURL)!)
      request.httpMethod = "POST"
      request.allHTTPHeaderFields = headers
      request.httpBody = jsonData as Data
      
      self.cancellable = URLSession.shared.dataTaskPublisher(for: request as URLRequest)
      .map { $0.data }
      .decode(type: User.self, decoder: JSONDecoder())
      .replaceError(with: dummyUser)
      .eraseToAnyPublisher()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { user in
        self.user = user
        UserDefaults.standard.set(user.id, forKey: "globalUserID")
        self.loading = false
        completion(true)
      })
    } catch {
      self.loading = false
      completion(false)
      print("Failed to Post User!")
    }
  }
  
  func updateData(completion: @escaping (_ success: Bool) -> Void) -> Void {
    self.loading = true
    do {
      let headers = [
        "Content-Type": "application/json",
        "Accept": "/",
        "Cache-Control": "no-cache",
        "Host": "fitnetic-api.herokuapp.com",
        "Accept-Encoding": "gzip, deflate",
        "Connection": "keep-alive"
      ]
      
      let userDict = [
        "username": self.user.username,
        "firstName": self.user.firstName,
        "lastName": self.user.lastName,
        "dateOfBirth": self.user.dateOfBirth,
        "gender": self.user.gender,
        "goal": self.user.goal
      ] as [String : Any]
      
      let jsonData = try JSONSerialization.data(withJSONObject: userDict, options: .prettyPrinted)
    
      var request = URLRequest(url: URL(string: self.postURL + self.user.id)!)
      request.httpMethod = "PATCH"
      request.allHTTPHeaderFields = headers
      request.httpBody = jsonData as Data
      
      self.cancellable = URLSession.shared.dataTaskPublisher(for: request as URLRequest)
      .map { $0.data }
      .decode(type: User.self, decoder: JSONDecoder())
      .replaceError(with: dummyUser)
      .eraseToAnyPublisher()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { user in
        self.user = user
        UserDefaults.standard.set(user.id, forKey: "globalUserID")
        self.loading = false
        completion(true)
      })
    } catch {
      self.loading = false
      completion(false)
      print("Failed to Post User!")
    }
  }
  
  func setUser(_ user: User) -> Void {
    self.user = user
  }
}

let dummyUser = User(
  id: "edcba123",
  username: "calvinhklui",
  firstName: "Calvin",
  lastName: "Lui",
  dateOfBirth: "N/A",
  gender: "Male",
  goal: "Gain Weight"
)
