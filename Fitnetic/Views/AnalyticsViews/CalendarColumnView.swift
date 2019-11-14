//
//  CalendarColumnView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CalendarColumnView: View {
  @Environment (\.colorScheme) var colorScheme: ColorScheme
  
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
      .foregroundColor(workedOut ? .white: .primary)
      .frame(width: 30, height: 30)
    }
    .background(workedOut ? LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom) : LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBackground), Color(UIColor.systemBackground)]), startPoint: .top, endPoint: .bottom))
    .cornerRadius(100)
  }
}

struct CalendarColumnView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarColumnView(day: 7,
                       workedOut: true)
  }
}
