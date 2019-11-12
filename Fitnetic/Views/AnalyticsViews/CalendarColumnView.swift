//
//  CalendarColumnView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CalendarColumnView: View {
  @Environment (\.colorScheme) var colorScheme:ColorScheme
  
  var day: String
  var workedOut: Bool
  var validDay: Bool
  
  init(day: Int?, workedOut: Bool) {
    if let day = day {
      self.day = String(day)
      self.validDay = true
    } else {
      self.day = " "
      self.validDay = false
    }
    self.workedOut = workedOut
  }
  
  var body: some View {
    VStack {
      Text(verbatim: day)
      .font(.system(size: 15))
      .fontWeight(workedOut ? .semibold : .regular)
      .lineLimit(1)
      .foregroundColor(.primary)
      .frame(width: 30, height: 30)
    }
    .overlay(Circle()
    .stroke(workedOut ? (colorScheme == .dark ? Color(UIColor.white) : Color(UIColor.black)) :
           (validDay ? Color(UIColor.systemGray6) :
           (colorScheme == .dark ? Color(UIColor.black) : Color(UIColor.white))),
            lineWidth: 2)
    .frame(width: 30, height: 30)
    )
  }
}

struct CalendarColumnView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarColumnView(day: 7,
                       workedOut: true)
  }
}
