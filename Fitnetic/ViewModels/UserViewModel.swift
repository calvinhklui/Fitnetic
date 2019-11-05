//
//  UserViewModel.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/4/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserViewModel: ObservableObject, Identifiable {
    @Published var user: User?
    private let userParser: UserParser
    
    init(userParser: UserParser) {
        self.userParser = userParser
        self.fetchUser(userID: "5dbf3ac810fe5000041aef80")
    }
    
    func fetchUser(userID: String) {
        DispatchQueue.main.async {
            self.userParser.getUserData(userID: userID, completionHandler: {user, error in
                if let user = user {
                    self.user = user
                }
            })
        }
    }
}
