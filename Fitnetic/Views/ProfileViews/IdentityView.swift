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
  
  init(userObserver: UserObserver) {
    self.userObserver = userObserver
  }
  
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .center) {
          Image(systemName: "person.circle.fill").resizable()
            .frame(width: 100, height: 100)
            .padding(.top, 10)
          Text(verbatim: "\(self.userObserver.user.firstName) \(self.userObserver.user.lastName)")
            .font(.system(size: 30))
            .fontWeight(.semibold)
            .foregroundColor(.primary)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .layoutPriority(100)
        Spacer()
      }
      .padding(20)
    }
    .background(Color.white)
  }
}

struct IdentityView_Previews: PreviewProvider {
    static var previews: some View {
        IdentityView(userObserver: UserObserver())
    }
}
