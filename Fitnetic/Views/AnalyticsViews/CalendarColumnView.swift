//
//  CalendarColumnView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CalendarColumnView: View {
  var day: String
  var workedOut: Bool
  var validDay: Bool
  
  init(day: Int?, workedOut: Bool) {
    if let day = day {
      self.day = String(day)
      self.validDay = true
    } else {
      self.day = "0"
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
      .foregroundColor(validDay ? .black : .white)
      .frame(width: 30, height: 30)
    }
    .overlay(Circle()
    .stroke(workedOut ? Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255, opacity: 1) :
      (validDay ? Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.4) :
        Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255, opacity: 0)),
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
