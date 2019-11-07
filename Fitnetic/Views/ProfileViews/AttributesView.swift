//
//  AttributesView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/6/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct AttributesView: View {
  @ObservedObject var userObserver: UserObserver
  var dateText: String = ""
  
  init(userObserver: UserObserver) {
    self.userObserver = userObserver
    
    // format workout date for display
    let oldDate = userObserver.user.dateOfBirth.replacingOccurrences(of: ".", with: "+")
    
    let dateFormatterISO8601 = ISO8601DateFormatter()
    let date = dateFormatterISO8601.date(from: oldDate)
    
    if let date = date {
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "en_US")
      dateFormatter.setLocalizedDateFormatFromTemplate("MMMMdy")
      dateText = dateFormatter.string(from: date)
    }
  }
  
  var body: some View {
    VStack{
      Group {
        HStack {
          Text(verbatim: "Gender")
            .fontWeight(.semibold)
            .foregroundColor(.primary)
          Spacer()
          Text(verbatim: "\(self.userObserver.user.gender)")
            .foregroundColor(.primary)
        }
        
        HStack {
          Text(verbatim: "Date of Birth")
            .fontWeight(.semibold)
            .foregroundColor(.primary)
          Spacer()
          Text(verbatim: "\(self.dateText)")
            .foregroundColor(.primary)
        }
        
        HStack {
          Text(verbatim: "Goal")
            .fontWeight(.semibold)
            .foregroundColor(.primary)
          Spacer()
          Text(verbatim: "\(self.userObserver.user.goal)")
            .foregroundColor(.primary)
        }
      }
      .layoutPriority(100)
      .padding(20)
    }.background(Color.white)
  }
}

struct AttributesView_Previews: PreviewProvider {
  static var previews: some View {
    AttributesView(userObserver: UserObserver())
  }
}
