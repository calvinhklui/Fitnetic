//
//  CalendarColumnView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CalendarColumnView: View {
  var month: String
  var day: Int
  var workedOut: Bool
  
  var body: some View {
    VStack {
      Text(verbatim: String(month.prefix(3)))
      
      Text(verbatim: "\(day)")
      .font(.system(size: 25))
      .fontWeight(.semibold)
      
      Spacer()
      
      if workedOut {
        Image(systemName: "checkmark.circle")
        .padding(.top, 15)
        .padding(.bottom, 5)
      }
    }
    .padding(10)
    .overlay(RoundedRectangle(cornerRadius: 10)
    .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.6), lineWidth: 1))
  }
}

struct CalendarColumnView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarColumnView(month: "November",
                       day: 7,
                       workedOut: true)
  }
}
