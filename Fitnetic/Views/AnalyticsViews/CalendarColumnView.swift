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
  
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct CalendarColumnView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarColumnView(day: "Monday", workedOut: true)
  }
}
