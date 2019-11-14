//
//  CalendarWeekView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WeekColumnView: View {
  var month: String
  var day: Int
  var workedOut: Bool
  
  var body: some View {
    VStack {
      Text(verbatim: String(month.prefix(3)))
      .foregroundColor(Color(UIColor.white))
      
      Text(verbatim: "\(day)")
      .font(.system(size: 25))
      .fontWeight(.semibold)
      .foregroundColor(Color(UIColor.white))
      
      Spacer()
      
      if workedOut {
        Image(systemName: "checkmark.circle")
        .foregroundColor(.white)
        .padding(.top, 15)
        .padding(.bottom, 5)
      }
    }
    .padding(10)
    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
    .cornerRadius(10)
  }
}

struct WeekColumnView_Previews: PreviewProvider {
    static var previews: some View {
        WeekColumnView(month: "November",
                         day: 7,
                         workedOut: true)
    }
}
