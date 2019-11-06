//
//  ProfileView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  @ObservedObject var userObserver: UserObserver
  
  init(userObserver: UserObserver) {
    self.userObserver = userObserver
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        Spacer()
        IdentityView(userObserver: self.userObserver)
        Spacer()
        AttributesView(userObserver: self.userObserver)
        Spacer()
      }
      .navigationBarTitle("Profile", displayMode: .large)
      .background(bgColor)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(userObserver: UserObserver())
  }
}
