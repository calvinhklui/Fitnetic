//
//  WeekView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WeekView: View {
  @State private var selectedTab = 0
  
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var analyticsObserver: AnalyticsObserver
  
  var daysList: [[String : Any]] = []
   
  init(workoutsObserver: WorkoutsObserver, exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, analyticsObserver: AnalyticsObserver) {
    self.workoutsObserver = workoutsObserver
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    self.analyticsObserver = analyticsObserver
    
    var start = 0
    if (self.analyticsObserver.analytics.workoutDatesList.count > 2) { start = 2 }
    
    for i in start ..< self.analyticsObserver.analytics.workoutDatesList.count {
      let workoutDate = self.analyticsObserver.analytics.workoutDatesList[i]
      let workoutBool = self.analyticsObserver.analytics.workoutBoolList[i]
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
      dateFormatter.locale = Locale(identifier: "en_US")
      let date = dateFormatter.date(from: workoutDate)
      
      var month: String = ""
      var dateOfMonth: String = ""
      if let date = date {
        dateFormatter.dateFormat = "LLLL"
        month = dateFormatter.string(from: date)
      
        dateFormatter.dateFormat = "dd"
        dateOfMonth = dateFormatter.string(from: date)
      }
      
      daysList.append(["month": month, "day": Int(dateOfMonth)!, "workedOut": workoutBool])
    }
  }
  
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          Text(verbatim: "This Week")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
          
          Text(verbatim: "Good habits yield strong results.")
            .font(.headline)
            .foregroundColor(Color(UIColor.systemGray2))
          
          Divider()
            .padding(.top, -5)
            .padding(.bottom, 15)
          
          HStack {
            ForEach((0 ..< self.daysList.count), id:\.self) { i in
              NavigationLink(destination: WorkoutListView(workoutsObserver: self.workoutsObserver,
                                                          exercisesObserver: self.exercisesObserver,
                                                          workoutObserver: self.workoutObserver)) {
                                                            WeekColumnView(month: self.daysList[i]["month"] as! String,
                                                            day: self.daysList[i]["day"] as! Int,
                                                            workedOut: self.daysList[i]["workedOut"] as! Bool)
              }
            }
          }
          .padding(.bottom, 30)
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
        .padding(20)
        .background(Color(UIColor.systemBackground))
      }
    }
  }
}

struct WeekView_Previews: PreviewProvider {
  static var previews: some View {
    WeekView(workoutsObserver: WorkoutsObserver(),
             exercisesObserver: ExercisesObserver(),
             workoutObserver: WorkoutObserver(),
             analyticsObserver: AnalyticsObserver())
  }
}
