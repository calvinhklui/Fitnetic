//
//  PreWorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct SetListView: View {
  @State var isEditMode: EditMode = .inactive
  
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  var workout: Workout
  
  @State var listItems = ["Item 1", "Item 2", "Item 3"]
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, workout: Workout) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    self.workout = workout
    
    UITableView.appearance().backgroundColor = UIColor.systemBackground
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(verbatim: "Sets")
        .font(.title)
        .fontWeight(.semibold)
        .foregroundColor(.primary)
      
      Divider()
        .padding(.top, -5)
      
      List {
        ForEach(self.workoutObserver.workout.sets) { set in
          SetRowView(set: set)
        }
        .onMove(perform: move)
        .onDelete(perform: delete)
      }
      .navigationBarItems(trailing: EditButton())
      .environment(\.editMode, self.$isEditMode)
      
    }
    .padding(20)
    .background(Color(UIColor.systemBackground))
    .onAppear(perform: {
      self.workoutObserver.setWorkout(self.workout)
    })
  }
  
  // Source: https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-move-rows-in-a-list
  func move(from source: IndexSet, to destination: Int) {
    self.workoutObserver.workout.sets.move(fromOffsets: source, toOffset: destination)
  }
  
  // Source: https://www.hackingwithswift.com/quick-start/swiftui/how-to-enable-editing-on-a-list-using-editbutton
  func delete(at offsets: IndexSet) {
    self.workoutObserver.workout.sets.remove(atOffsets: offsets)
  }
}

struct SetListView_Previews: PreviewProvider {
  static var previews: some View {
    SetListView(exercisesObserver: ExercisesObserver(),
                workoutObserver: WorkoutObserver(),
                workout: dummyRecommendation)
  }
}
