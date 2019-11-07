//
//  CalendarHeaderView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CalendarHeaderView: View {
  var dayOfWeekList = ["S", "M", "T", "W", "T", "F", "S"]
  
  var body: some View {
    HStack {
      ForEach((0 ..< self.dayOfWeekList.count), id:\.self) { i in
        VStack {
          Text(self.dayOfWeekList[i])
          .font(.system(size: 15))
          .frame(width: 30, height: 30)
        }
        .overlay(Circle()
        .stroke(Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255, opacity: 0),lineWidth: 2))
        .frame(width: 30, height: 30)
      }
    }
  }
}

struct CalendarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
      CalendarHeaderView()
    }
}
