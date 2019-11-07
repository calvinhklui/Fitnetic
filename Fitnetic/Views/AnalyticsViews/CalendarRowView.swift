//
//  CalendarView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CalendarRowView: View {
  var week: [(Int?, Bool)] = []
  
  var body: some View {
    HStack {
      ForEach((0 ..< self.week.count), id:\.self) { i in
        CalendarColumnView(day: self.week[i].0,
                           workedOut: self.week[i].1)
      }
    }
  }
}

struct CalendarRowView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarRowView(week: [])
  }
}
