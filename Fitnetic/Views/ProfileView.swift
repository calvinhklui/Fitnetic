//
//  ProfileView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("hello world")
            }
            .navigationBarTitle("Profile", displayMode: .large)
            .background(bgColor)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userViewModel: UserViewModel(userParser: UserParser()))
    }
}
