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
              HStack {
                Text(verbatim: "\(self.analyticsObserver.analytics.numWorkouts)")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(.primary)
                if (self.analyticsObserver.analytics.numWorkoutsTrend == -1) {
                  Image(systemName: "arrowtriangle.down.fill")
                  .foregroundColor(.red)
                } else if (self.analyticsObserver.analytics.numWorkoutsTrend == 1) {
                  Image(systemName: "arrowtriangle.up.fill")
                  .foregroundColor(.green)
                } else {
                  Image(systemName: "arrowtriangle.right.fill")
                  .foregroundColor(Color(UIColor.systemBackground))
                }
              }
              Text(verbatim: "Workouts")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
              HStack {
                Text(verbatim: "\(self.analyticsObserver.analytics.numSets)")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(.primary)
                if (self.analyticsObserver.analytics.numSetsTrend == -1) {
                  Image(systemName: "arrowtriangle.down.fill")
                  .foregroundColor(.red)
                } else if (self.analyticsObserver.analytics.numSetsTrend == 1) {
                  Image(systemName: "arrowtriangle.up.fill")
                  .foregroundColor(.green)
                } else {
                  Image(systemName: "arrowtriangle.right.fill")
                  .foregroundColor(Color(UIColor.systemBackground))
                }
              }
              Text(verbatim: "Exercises")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
              HStack {
                Text(verbatim: "\(self.analyticsObserver.analytics.numMusclesHit)")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(.primary)
                if (self.analyticsObserver.analytics.numMusclesHitTrend == -1) {
                  Image(systemName: "arrowtriangle.down.fill")
                  .foregroundColor(.red)
                } else if (self.analyticsObserver.analytics.numMusclesHitTrend == 1) {
                  Image(systemName: "arrowtriangle.up.fill")
                  .foregroundColor(.green)
                } else {
                  Image(systemName: "arrowtriangle.right.fill")
                  .foregroundColor(Color(UIColor.systemBackground))
                }
              }
              Text(verbatim: "Muscles")
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
    .background(Color(UIColor.systemBackground))
  }
}

struct StatisticView_Previews: PreviewProvider {
  static var previews: some View {
    StatisticView(analyticsObserver: AnalyticsObserver())
  }
}
