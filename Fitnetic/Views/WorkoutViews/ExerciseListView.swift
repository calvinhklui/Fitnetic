//
//  ExerciseListView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/15/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct ExerciseListView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State private var reps: String = ""
  @State private var exercise: String = ""
  
  @State var data: [(String, [String])] = [
      ("Reps", Array(0...100).map { "\($0)" }),
      ("Exercises", [""])
  ]
  @State var selection: [String] = [0, ""].map { "\($0)" }
  
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  
  var body: some View {
    VStack {
      Form {
        Section {
          MultiPicker(data: data, selection: $selection)
            .frame(height: 250)
        }
        
        HStack {
          Text(verbatim: "\(selection[0])")
            .font(.title)
            .foregroundColor(.gray)
          Text(verbatim: "\(selection[1])")
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
      }
      .frame(height: 400)
      
      HStack (alignment: .bottom) {
        Button(action: {
          if (self.exercisesObserver.exercises.count > 0 && self.selection[0] != "0" && self.selection[1] != "") {
            let newWorkoutSet = WorkoutSet(
              exercise: self.exercisesObserver.exercises.first(where: { $0.name == self.selection[1] })!,
              reps: Int(self.selection[0]),
              difficulty: 0
            )
            
            self.workoutObserver.workout.sets.append(newWorkoutSet)
            self.presentationMode.wrappedValue.dismiss()
          }
        }) {
          VStack {
            HStack {
              VStack {
                Text(verbatim: "Add")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(Color(UIColor.white))
              }
            }
          }
          .padding(.horizontal, 30)
          .padding(.vertical, 15)
          .foregroundColor(.primary)
          .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
          .cornerRadius(30)
        }
        
        Button(action: {
              self.presentationMode.wrappedValue.dismiss()
              }) {
                VStack {
                  HStack {
                    VStack {
                      Text(verbatim: "Cancel")
                        .font(.headline)
                        .foregroundColor(Color(UIColor.white))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.primary)
                        .background(Color(UIColor.systemRed))
                        .cornerRadius(30)
                    }
                  }
                }
              }
      }
      .padding(.bottom, 20)
    }
    .navigationBarTitle("New Set")
    .onAppear(perform: {
      self.data = [
          ("Reps", Array(0...100).map { "\($0)" }),
          ("Exercises", self.exercisesObserver.exercises.map { "\($0.name)" })
      ]
    })
  }
}

// Source: https://stackoverflow.com/questions/56567539/multi-component-picker-uipickerview-in-swiftui
struct MultiPicker: View  {

    typealias Label = String
    typealias Entry = String

    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                            .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
  static var previews: some View {
      ExerciseListView(exercisesObserver: ExercisesObserver(), workoutObserver: WorkoutObserver())
  }
}
