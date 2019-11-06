//
//  WorkoutRowView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/5/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WorkoutRowView: View {
  var workout: Workout
  var dateText: String = ""
  var setsText: String = ""
  
  init(workout: Workout) {
    self.workout = workout
    
    // format workout date for display
    let oldDate = workout.date.replacingOccurrences(of: ".", with: "+")
    
    let dateFormatterISO8601 = ISO8601DateFormatter()
    let date = dateFormatterISO8601.date(from: oldDate)!

    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
    dateText = dateFormatter.string(from: date)
    
    // format workout sets for display
    for i in 0 ..< workout.sets.count {
      let reps = workout.sets[i].reps
      let time = workout.sets[i].time
      
      if let reps = reps {
        self.setsText = self.setsText + "\(workout.sets[i].exercise.name) x\(reps)\n"
      } else if let time = time {
        self.setsText = self.setsText + "\(workout.sets[i].exercise.name) x\(time)\n"
      } else {
        self.setsText = self.setsText + "\(workout.sets[i].exercise.name)\n"
      }
    }
  }
  
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          Text(dateText)
            .font(.title)
            .fontWeight(.black)
            .foregroundColor(.primary)
            .padding(.bottom, 10)
          Text(setsText)
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .layoutPriority(100)
        Spacer()
      }
      .padding(20)
    }
  }
}

//struct WorkoutRowView_Previews: PreviewProvider {
//  static var previews: some View {
//    WorkoutRowView()
//  }
//}
