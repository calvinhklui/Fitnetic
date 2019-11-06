//
//  PreWorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct SetListView: View {
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  var workout: Workout
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, workout: Workout?) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    
    // logic for workout (selected vs. recommended)
    if let workout = workout {
      self.workout = workout
    } else {
      self.workout = workoutObserver.workout
    }
  }
  
  var body: some View {
    VStack {
      List {
        ForEach((0 ..< self.workout.sets.count), id:\.self) { i in
          SetRowView(set: self.workout.sets[i])
        }
        .onMove(perform: move)
      }
      .navigationBarItems(trailing: EditButton())
      .padding(.horizontal, 20)
      .padding(.top, 20)
      
      ScrollView {
        NavigationLink(destination: SetDetailView(exercisesObserver: self.exercisesObserver,
                                                  workoutObserver: self.workoutObserver)) {
          VStack {
            HStack {
              VStack() {
                Text("Start")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(.primary)
              }
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
            .padding(20)
          }
        }
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.6), lineWidth: 1))
        .padding(.all, 40)
      }
      .onAppear(perform: { self.workoutObserver.setWorkout(self.workout) })
      .navigationBarTitle(Text("Sets"))
    }
  }
  
  // Source: https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-move-rows-in-a-list
  func move(from source: IndexSet, to destination: Int) {
      self.workoutObserver.workout.sets.move(fromOffsets: source, toOffset: destination)
  }
}

struct SetListView_Previews: PreviewProvider {
  static var previews: some View {
    SetListView(exercisesObserver: ExercisesObserver(),
                workoutObserver: WorkoutObserver(),
                workout: nil)
  }
}
