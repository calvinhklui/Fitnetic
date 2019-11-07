//
//  WeekView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WeekView: View {
  @State private var selectedTab = 0
  
  @ObservedObject var analyticsObserver: AnalyticsObserver
  
  var daysList = [
     ["month": "November", "day": 3, "workedOut": false],
     ["month": "November", "day": 4, "workedOut": false],
     ["month": "November", "day": 5, "workedOut": true],
     ["month": "November", "day": 6, "workedOut": false],
     ["month": "November", "day": 7, "workedOut": true]
   ]
   
  
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
            .padding(.bottom, 15)
          
          HStack {
            ForEach((0 ..< self.daysList.count), id:\.self) { i in
              WeekColumnView(month: self.daysList[i]["month"] as! String,
                             day: self.daysList[i]["day"] as! Int,
                             workedOut: self.daysList[i]["workedOut"] as! Bool)
            }
          }
          .padding(.bottom, 30)
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
        .padding(20)
        .background(Color.white)
      }
    }
  }
}

struct WeekView_Previews: PreviewProvider {
  static var previews: some View {
    WeekView(analyticsObserver: AnalyticsObserver())
  }
}
