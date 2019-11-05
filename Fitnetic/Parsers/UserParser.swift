//
//  UserParser.swift
//  Fitnetic
//
//  Created by 丑诗祺 on 2019/11/3.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation

class UserParser {
    var userURL: String

    init() {
        self.userURL = "https://fitnetic-api.herokuapp.com/users/"
    }

    // Source: https://fluffy.es/return-value-from-a-closure/
    func getUserData(userID: String, completionHandler: @escaping (User?, Error?) -> Void) {
        let destinationURL = self.userURL + userID
        let task = URLSession.shared.dataTask(with: URL(string: destinationURL)!) { (data, response, error) in
            guard let data = data else {
                print("Error: No user data to decode")
                return
            }

            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                print("Error: Couldn't decode user data into a result")
                return
            }
            
            completionHandler(user, nil)
        }

        task.resume()
    }
}
