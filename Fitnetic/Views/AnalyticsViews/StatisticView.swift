//
//  StatisticView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/6/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct StatisticView: View {
    var body: some View {
        VStack {
          HStack {
            VStack(alignment: .leading) {
              VStack(alignment: .leading) {
                Text(verbatim: "Previous Workouts")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(.primary)
                Text(verbatim: "Explore your past.")
                  .font(.caption)
                  .foregroundColor(.secondary)
                  .lineLimit(3)
              }
              .layoutPriority(100)
              .cornerRadius(10)
              .padding(.bottom, 20)
            }
            .layoutPriority(100)
            Spacer()
          }
          .padding(20)
        }
        .background(Color.white)
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
