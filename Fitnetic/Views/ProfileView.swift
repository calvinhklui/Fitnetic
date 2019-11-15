//
//  ProfileView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  @State var isEditMode: EditMode = .inactive
  
  @ObservedObject var userObserver: UserObserver
  
  init(userObserver: UserObserver) {
    self.userObserver = userObserver
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        if self.isEditMode == .inactive {
            Spacer()
            IdentityView(userObserver: self.userObserver)
            Spacer()
            AttributesView(userObserver: self.userObserver)
            Spacer()
        } else {
          EditProfileView(userObserver: self.userObserver)
        }
      }
      .navigationBarTitle("Profile", displayMode: .large)
      .navigationBarItems(trailing: EditButton())
      .environment(\.editMode, self.$isEditMode)
      .background(Color(UIColor.systemGray6))
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .onAppear(perform: {
      self.userObserver.fetchData()
    })
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(userObserver: UserObserver())
  }
}
