//
//  ExerciseRowView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct SetRowView: View {
  var set: WorkoutSet
  var number: String = ""
  
  init(set: WorkoutSet) {
    self.set = set
    
    print("Displayed Workout Set: \(set)")
    
    // format number (either reps or time)
    let reps = set.reps
    let time = set.time
    
    if let reps = reps {
      self.number = "\(reps)"
    } else if let time = time {
      self.number = "\(time)"
    } else {
      self.number = "N/A"
    }
  }
  
  var body: some View {
    HStack {
      Text(number)
        .font(.title)
        .foregroundColor(.gray)
//        .keyboardType(.numberPad)
      Text(set.exercise.name)
    }
    .padding(.vertical, 10)
  }
}

//struct SetRowView_Previews: PreviewProvider {
//  static var previews: some View {
//    SetRowView()
//  }
//}
