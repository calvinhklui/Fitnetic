//
//  AnalyticsView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct AnalyticsView: View {
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var analyticsObserver: AnalyticsObserver
  
  init(workoutsObserver: WorkoutsObserver, analyticsObserver: AnalyticsObserver) {
    self.workoutsObserver = workoutsObserver
    self.analyticsObserver = analyticsObserver
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        Spacer()
        StatisticView(analyticsObserver: self.analyticsObserver)
        Spacer()
        GraphicView(workoutsObserver: self.workoutsObserver,
                    analyticsObserver: self.analyticsObserver)
      }
      .navigationBarTitle("Record", displayMode: .large)
      .navigationBarItems(trailing:
        Button(action: {
          self.workoutsObserver.fetchData()
          self.analyticsObserver.fetchData()
        }) {
          VStack {
            HStack {
              VStack {
                Image(systemName: "arrow.clockwise.circle.fill")
                  .font(.system(size: 35))
                  .foregroundColor(Color(UIColor.systemBlue))
              }
            }
          }
          .padding(.top, 95)
          .padding(.bottom, 5)
        }
      )
      .background(Color(UIColor.systemGray6))
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct AnalyticsView_Previews: PreviewProvider {
  static var previews: some View {
    AnalyticsView(workoutsObserver: WorkoutsObserver(),
                  analyticsObserver: AnalyticsObserver())
  }
}
