//
//  UserParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

class UserParser {
  var userID: String
  var userURL: String
  var user: User?

  init() {
    self.userID = "5dbf3ac810fe5000041aef80"
    self.userURL = "https://fitnetic-api.herokuapp.com/users/" + self.userID
    self.getUserData()
  }

  func getUserData() {
    let task = URLSession.shared.dataTask(with: URL(string: self.userURL)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }

        guard let user = try? JSONDecoder().decode(User.self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
        }
        
        self.user = user
    }
    
    task.resume()
  }
    
  func getUser() -> User? {
    return self.user
  }
}
