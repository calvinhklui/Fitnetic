//
//  IdentityView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/6/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct IdentityView: View {
  @ObservedObject var userObserver: UserObserver
  var showDetails: Bool
  
  init(userObserver: UserObserver, showDetails: Bool) {
    self.userObserver = userObserver
    self.showDetails = showDetails
  }
  
  var body: some View {
    VStack {
      HStack {
        if (showDetails) {
          VStack(alignment: .leading) {
            Image("avatar").resizable()
              .frame(width: 100, height: 100)
          }
          .padding()
          
          VStack(alignment: .leading) {
            Text(verbatim: "\(self.userObserver.user.firstName) \(self.userObserver.user.lastName)")
              .font(.title)
              .fontWeight(.semibold)
              .foregroundColor(.primary)
            Text(verbatim: "@\(self.userObserver.user.username)")
              .font(.headline)
              .fontWeight(.light)
              .foregroundColor(Color(UIColor.systemGray2))
          }
          
          Spacer()
        } else {
          VStack(alignment: .leading) {
            Image("avatar").resizable()
              .frame(width: 100, height: 100)
          }
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
          .layoutPriority(100)
        }
      }
      .padding(20)
    }
    .background(Color(UIColor.systemBackground))
  }
}

struct IdentityView_Previews: PreviewProvider {
  static var previews: some View {
    IdentityView(userObserver: UserObserver(), showDetails: true)
  }
}
