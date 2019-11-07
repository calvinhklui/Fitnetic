//
//  GraphicView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/6/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct GraphicView: View {
  @State private var selectedTab = 0
  
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var analyticsObserver: AnalyticsObserver
  @ObservedObject var graphicObserver: GraphicObserver
  
  init(workoutsObserver: WorkoutsObserver, analyticsObserver: AnalyticsObserver, graphicObserver: GraphicObserver) {
    self.workoutsObserver = workoutsObserver
    self.analyticsObserver = analyticsObserver
    self.graphicObserver = graphicObserver
  }
  
  var body: some View {
    VStack {
      Picker(selection: $selectedTab, label: Text("Analytics")) {
        Text("Calendar").tag(0)
        Text("Body").tag(1)
      }
      .pickerStyle(SegmentedPickerStyle())
      .padding(20)
      
      if selectedTab == 0 {
        CalendarView(workoutsObserver: self.workoutsObserver)
      } else {
        Image(uiImage: self.graphicObserver.imageFromData())
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding(20)
      }
    }
    .background(Color.white)
  }
}

struct GraphicView_Previews: PreviewProvider {
  static var previews: some View {
    GraphicView(workoutsObserver: WorkoutsObserver(),
                analyticsObserver: AnalyticsObserver(),
                graphicObserver: GraphicObserver())
  }
}
