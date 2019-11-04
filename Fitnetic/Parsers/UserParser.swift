//
//  UserParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

class UserParser {
  var userId: String
  var userURL: String

  init() {
    self.userId = "5dbf3ac810fe5000041aef80"
    self.userURL = "https://fitnetic-api.herokuapp.com/users/" + self.userId
  }

  func getUserData(userCompletionHandler: @escaping (User?, Error?) -> Void) {
    let UserTask = URLSession.shared.dataTask(with: URL(string: userURL)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }

        guard let user = try? JSONDecoder().decode(User.self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
      }
      userCompletionHandler(user, nil)
    }
    UserTask.resume()
  }
}

// Use the code below in user class to populate users' attributes

//let parser1 = UserParser()
//parser1.getUserData(userCompletionHandler: { user, error in
//  if let user = user {
//    self.firstName.text = user.firstName
//    print("user first name is : \(user.firstName)")
//  }
//})
