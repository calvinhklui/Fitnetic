//
//  CalendarView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
  @ObservedObject var workoutsObserver: WorkoutsObserver
  
  var currentMonth: String
  var startOffset: Int
  var numDaysInMonth: Int
  var weeks: [[(Int?, Bool)]] = []
  var dateFormatter: DateFormatter = DateFormatter()
  
  init(workoutsObserver: WorkoutsObserver) {
    self.workoutsObserver = workoutsObserver
    
    let today = Date()
    dateFormatter.dateFormat = "LLLL"
    currentMonth = dateFormatter.string(from: today)
    
    let calendar = Calendar(identifier: .gregorian)
    let weekDay = calendar.component(.weekday, from: today)
    startOffset = weekDay // 0 = Sunday, 6 = Saturday

    let range = calendar.range(of: .day, in: .month, for: today)!
    numDaysInMonth = range.count
    
    let daysWithWorkouts = self.workoutsObserver.workouts.compactMap {
      self.filterWorkoutDates(workoutDate: $0.date)
    }
    
    var daysCounter = 1
    var currentWeek: [(Int?, Bool)] = []
    var dayWorkedOut: Bool
    for i in 0 ..< (startOffset + numDaysInMonth) {
      var day: Int? = i - startOffset + 1
      
      dayWorkedOut = daysWithWorkouts.contains(day!)
      if (day! < 1) {
        day = nil
      }
      
      currentWeek.append((day, dayWorkedOut))
      
      if (daysCounter > 6) {
        weeks.append(currentWeek)
        daysCounter = 0
        currentWeek = []
      }
      daysCounter += 1
    }
    
    if (currentWeek.count > 0) {
      while (currentWeek.count < 7) {
        currentWeek.append((nil, false))
      }
      weeks.append(currentWeek)
    }
  }
  
  func filterWorkoutDates(workoutDate: String) -> Int? {
    let workoutDate = workoutDate.replacingOccurrences(of: ".", with: "+")
    let dateFormatterISO8601 = ISO8601DateFormatter()
    let date = dateFormatterISO8601.date(from: workoutDate)
    
    if let date = date {
      dateFormatter.dateFormat = "LLLL"
      let month = dateFormatter.string(from: date)
      
      if (currentMonth == month) {
        dateFormatter.dateFormat = "dd"
        return Int(dateFormatter.string(from: date))
      } else { return nil }
    } else { return nil }
  }
  
  var body: some View {
    VStack {
      Text(verbatim: currentMonth)
      .font(.headline)
      .padding(.bottom, 15)
      
      CalendarHeaderView()
      .padding(.horizontal, 40)
      
      Divider()
      .padding(.top, -5)
      .padding(.horizontal, 40)
      .padding(.bottom, 5)
      
      ForEach((0 ..< self.weeks.count), id:\.self) { i in
        CalendarRowView(week: self.weeks[i])
        .padding(.horizontal, 40)
      }
      .padding(.bottom, 10)
    }
    .padding(.bottom, 20)
  }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
      CalendarView(workoutsObserver: WorkoutsObserver())
    }
}
