//
//  TodayDetailView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct TodayDetailView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State var isPreWorkout: Bool = true
  @State var showPopover: Bool = false
  @State var restTimeSelection: Int = 0
  @State var restTimes = [15, 30, 60]
  
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  var workout: Workout
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, workout: Workout?) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    
    if let workout = workout {
      self.workout = workout  // for selected workout
    } else {
      self.workout = workoutObserver.workout // for blank workout
    }
    
    UITableView.appearance().backgroundColor = UIColor.systemBackground
  }
  
  var body: some View {
    VStack {
      Spacer()
      
      SetListView(exercisesObserver: self.exercisesObserver, workoutObserver: self.workoutObserver, workout: self.workout)
        .frame(height: 400)
      
      Spacer()
      
      if (self.isPreWorkout) {
        VStack(alignment: .leading) {
          Text(verbatim: "Rest Time")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
          
          Divider()
            .padding(.top, -5)
          
          Picker(selection: $restTimeSelection, label: Text("Rest Time")) {
            ForEach(0 ..< self.restTimes.count) {
              Text("\(self.restTimes[$0])s").tag($0)
            }
          }.pickerStyle(SegmentedPickerStyle())
        }
        .padding(20)
        .background(Color(UIColor.systemBackground))
        
        Spacer()
      
        Button(action: {
          if (self.workoutObserver.workout.sets.count > 0) {
            self.showPopover = true
            self.isPreWorkout = false
          }
        }) {
          GeometryReader { geometry in
            VStack {
              HStack {
                VStack {
                  Text(verbatim: "Start")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color(UIColor.white))
                }
              }
            }
            .frame(width: geometry.size.width)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .foregroundColor(.primary)
            .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(10)
          }
        }
        .padding(.horizontal, 50)
        .padding(.bottom, 5)
      } else {
        Button(action: {
          self.workoutObserver.postData(completion: { (success) -> Void in
            if success {
              self.workoutObserver.fetchData()
              self.presentationMode.wrappedValue.dismiss()
            }
          })
        }) {
          GeometryReader { geometry in
            VStack {
              HStack {
                VStack {
                  if (self.workoutObserver.loading) {
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                  } else {
                    Text(verbatim: "Save")
                      .font(.title)
                      .fontWeight(.black)
                      .foregroundColor(Color(UIColor.white))
                  }
                }
              }
            }
            .frame(width: geometry.size.width)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .foregroundColor(.primary)
            .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(10)
          }
          .frame(height: 50)
        }
        .padding(.horizontal, 50)
        .padding(.bottom, 20)
        .navigationBarBackButtonHidden(true)
      }
    }
    .popover(
      isPresented: self.$showPopover,
      arrowEdge: .bottom
    ) {
      ZStack {
        SetDetailView(exercisesObserver: self.exercisesObserver,
                      workoutObserver: self.workoutObserver,
                      restTime: self.restTimes[self.restTimeSelection])
        
        VStack {
          HStack {
            Button(action: {
              self.isPreWorkout = true
              self.showPopover = false
            }) {
              HStack {
                Image(systemName: "xmark.circle.fill")
                  .font(.title)
                  .foregroundColor(Color(UIColor.systemRed))
              }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
            
            Spacer()
            
            // pause button?
          }
          Spacer()
        }
      }
    }
    .navigationBarTitle("Today", displayMode: .inline)
    .background(Color(UIColor.systemGray6))
  }
}

struct TodayDetailView_Previews: PreviewProvider {
  static var previews: some View {
    TodayDetailView(exercisesObserver: ExercisesObserver(),
                    workoutObserver: WorkoutObserver(),
                    workout: nil)
  }
}
