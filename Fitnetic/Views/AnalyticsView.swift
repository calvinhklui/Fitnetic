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
  var workedOutToday: Bool
  
  init(workoutsObserver: WorkoutsObserver, analyticsObserver: AnalyticsObserver, workedOutToday: Bool) {
    self.workoutsObserver = workoutsObserver
    self.analyticsObserver = analyticsObserver
    self.workedOutToday = workedOutToday
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
          VStack {
            HStack {
              VStack {
                if (self.workoutsObserver.loading || self.analyticsObserver.loading) {
                  ActivityIndicator(isAnimating: .constant(true), style: .medium)
                } else {
                  if (workedOutToday) {
                    Image(systemName: "checkmark.circle.fill")
                      .font(.system(size: 30))
                      .foregroundColor(Color(UIColor.systemBlue))
                  } else {
                    Image(systemName: "circle")
                    .font(.system(size: 30))
                    .foregroundColor(Color(UIColor.systemBlue))
                  }
                }
              }
            }
          }
          .padding(.top, 95)
          .padding(.bottom, 5)
      )
      .background(Color(UIColor.systemGray6))
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .onAppear(perform: {
      self.workoutsObserver.fetchData()
      self.analyticsObserver.fetchData()
      self.analyticsObserver.fetchSVG()
    })
  }
}

struct AnalyticsView_Previews: PreviewProvider {
  static var previews: some View {
    AnalyticsView(workoutsObserver: WorkoutsObserver(),
                  analyticsObserver: AnalyticsObserver(),
                  workedOutToday: false)
  }
}
