//
//  WorkoutSummaryView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/6/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WorkoutSummaryView: View {
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
  }
  
  var body: some View {
    VStack {
      List {
        ForEach((0 ..< self.workoutObserver.workout.sets.count), id:\.self) { i in
          SetRowView(set: self.workoutObserver.workout.sets[i])
        }
        .onMove(perform: move)
      }
      .navigationBarItems(trailing: EditButton())
      .padding(.horizontal, 20)
      .padding(.top, 20)
      
      ScrollView {
        NavigationLink(destination: ContentView()) {
          VStack {
            HStack {
              VStack() {
                Text(verbatim: "Save")
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
      .navigationBarTitle(Text("Summary"))
    }
  }
  
  // Source: https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-move-rows-in-a-list
  func move(from source: IndexSet, to destination: Int) {
      self.workoutObserver.workout.sets.move(fromOffsets: source, toOffset: destination)
  }
}

struct WorkoutSummaryView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutSummaryView(exercisesObserver: ExercisesObserver(),
                workoutObserver: WorkoutObserver())
  }
}
