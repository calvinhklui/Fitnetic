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
  
  init(exercisesObserver: ExercisesObserver, workoutObserver: WorkoutObserver, workout: Workout) {
    self.exercisesObserver = exercisesObserver
    self.workoutObserver = workoutObserver
    self.workout = workout
    
    UITableView.appearance().backgroundColor = UIColor.systemBackground
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(verbatim: "Sets")
          .font(.title)
          .fontWeight(.semibold)
          .foregroundColor(.primary)
      
        Spacer()
        
        HStack {
          NavigationLink(destination: ExerciseListView(exercisesObserver: self.exercisesObserver, workoutObserver: self.workoutObserver)) {
            VStack {
              HStack {
                VStack {
                  Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .foregroundColor(.primary)
                }
              }
            }
          }
          
          Button(action: {
            if (self.isEditMode == .inactive) {
              self.isEditMode = .active
            } else {
              self.isEditMode = .inactive
            }
          }) {
            VStack {
              HStack {
                VStack {
                  Image(systemName: "pencil.circle.fill")
                    .font(.title)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .foregroundColor(.primary)
                }
              }
            }
          }
        }
      }
      
      Divider()
        .padding(.top, -5)
      
      List {
        ForEach(self.workoutObserver.workout.sets) { set in
          SetRowView(set: set)
        }
        .onMove(perform: move)
        .onDelete(perform: delete)
      }
      .environment(\.editMode, self.$isEditMode)
      
    }
    .padding(20)
    .background(Color(UIColor.systemBackground))
    .onAppear(perform: {
      if (self.workoutObserver.workout.id != self.workout.id) {
        self.workoutObserver.setWorkout(self.workout)
      }
    })
  }
  
  func move(from source: IndexSet, to destination: Int) {
    self.workoutObserver.workout.sets.move(fromOffsets: source, toOffset: destination)
  }
  
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
