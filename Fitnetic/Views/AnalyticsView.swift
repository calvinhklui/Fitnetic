//
//  AnalyticsView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct AnalyticsView: View {
  @ObservedObject var analyticsObserver: AnalyticsObserver
  @ObservedObject var graphicObserver: GraphicObserver
  
  init(analyticsObserver: AnalyticsObserver, graphicObserver: GraphicObserver) {
    self.analyticsObserver = analyticsObserver
    self.graphicObserver = graphicObserver
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        Spacer()
        StatisticView(analyticsObserver: self.analyticsObserver)
        Spacer()
        GraphicView(analyticsObserver: self.analyticsObserver,
                    graphicObserver: self.graphicObserver)
      }
      .navigationBarTitle("Analytics", displayMode: .large)
      .background(bgColor)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct AnalyticsView_Previews: PreviewProvider {
  static var previews: some View {
    AnalyticsView(analyticsObserver: AnalyticsObserver(),
                  graphicObserver: GraphicObserver())
  }
}
