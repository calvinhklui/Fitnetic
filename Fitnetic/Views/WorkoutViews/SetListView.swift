//
//  PreWorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct SetListView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @State var isEditMode: EditMode = .inactive
  @State var isPreWorkout: Bool = true
  @State private var showPopover: Bool = false
  
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
        .onDelete(perform: delete)
      }
      .navigationBarItems(trailing: EditButton())
      .environment(\.editMode, self.$isEditMode)
      .padding(.horizontal, 20)
      .padding(.top, 20)
      
      Spacer()
      
      ScrollView {
        if (self.isPreWorkout) {
          Button(action: {
            self.showPopover = true
            self.isPreWorkout = false
          }) {
            VStack {
              HStack {
                VStack {
                  Text(verbatim: "Start")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .padding(.bottom, 10)
                }
              }
            }
          }
        } else {
          Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            self.workoutObserver.postData()
          }) {
            VStack {
              HStack {
                VStack {
                  Text(verbatim: "Save")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .padding(.bottom, 10)
                }
              }
            }
          }
          .navigationBarBackButtonHidden(true)
        }
        
        ScrollView { EmptyView() }
          .popover(
            isPresented: self.$showPopover,
            arrowEdge: .bottom
          ) {
            VStack {
              HStack {
                Button(action: {
                  self.isPreWorkout = true
                  self.showPopover = false
                }) {
                  HStack {
                    Text(verbatim: "Cancel")
                      .foregroundColor(.red)
                  }
                }
                .padding(20)
                
                Spacer()
              }
              SetDetailView(exercisesObserver: self.exercisesObserver,
                            workoutObserver: self.workoutObserver)
            }
        }
      }
      .onAppear(perform: { self.workoutObserver.setWorkout(self.workout) })
      .navigationBarTitle(Text("Sets"))
    }
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
                workout: nil)
  }
}
