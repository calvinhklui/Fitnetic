//
//  CardView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CardView: View {
    private var title: String

    init(title: String) {
        self.title = title
    }
    
    var body: some View {
      VStack {
        HStack {
          VStack(alignment: .leading) {
            Text(self.title)
              .font(.title)
              .fontWeight(.black)
              .foregroundColor(.primary)
            Text("Hello, I'm stupid.")
            .font(.headline)
            .foregroundColor(.secondary)
          }
          .layoutPriority(100)
          Spacer()
        }
        .padding(20)
      }
      .background(Color.white)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Today")
    }
}
