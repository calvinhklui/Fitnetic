//
//  StatisticView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/6/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct StatisticView: View {
  @ObservedObject var analyticsObserver: AnalyticsObserver
  
  init(analyticsObserver: AnalyticsObserver) {
    self.analyticsObserver = analyticsObserver
  }
  
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          Text(verbatim: "This Week")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
          
          Divider()
          .padding(.top, -5)
          .padding(.bottom, 5)
          
          HStack {
            VStack(alignment: .leading) {
              Text(verbatim: "\(5)")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
              Text(verbatim: "Workouts")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
              Text(verbatim: "\(5)")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
              Text(verbatim: "Workouts")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
              Text(verbatim: "\(5)")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
              Text(verbatim: "Workouts")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          }
          .padding(.horizontal, 15)
        }
        .layoutPriority(100)
        .cornerRadius(10)
        Spacer()
      }
      .padding(20)
    }
    .background(Color.white)
  }
}

struct StatisticView_Previews: PreviewProvider {
  static var previews: some View {
    StatisticView(analyticsObserver: AnalyticsObserver())
  }
}
