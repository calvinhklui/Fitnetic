//
//  CalendarView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
  @ObservedObject var analyticsObserver: AnalyticsObserver
  
  init(analyticsObserver: AnalyticsObserver) {
    self.analyticsObserver = analyticsObserver
  }
  
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView(analyticsObserver: AnalyticsObserver())
  }
}
