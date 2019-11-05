//
//  PreWorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct PreWorkoutView: View {
    @ObservedObject var recommendationViewModel: RecommendationViewModel
    @ObservedObject var exercisesViewModel: ExercisesViewModel
    
    init(exercisesViewModel: ExercisesViewModel,
         recommendationViewModel: RecommendationViewModel) {
        self.exercisesViewModel = exercisesViewModel
        self.recommendationViewModel = recommendationViewModel
    }
    
    var body: some View {
        ScrollView {
            Spacer()
            
            Text("hello")
            
            List(self.recommendationViewModel.recommendation?.sets ?? [], id: \.reps) {set in
                SetRowView(set: set)
            }
            
            Spacer()
            
            NavigationLink(destination: SetDetailView()) {
               VStack {
                   HStack {
                     VStack() {
                       Text("Start")
                             .font(.title)
                             .fontWeight(.black)
                             .foregroundColor(.primary)
                     }
                     .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                     .layoutPriority(100)
                     Spacer()
                   }
                   .padding(20)
               }
           }
           .cornerRadius(10)
           .overlay(RoundedRectangle(cornerRadius: 10)
               .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.6), lineWidth: 1))
           .padding(.all, 20)
        }
        .navigationBarTitle(Text("Sets"))
    }
}

struct PreWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        PreWorkoutView(exercisesViewModel: ExercisesViewModel(exercisesParser: ExercisesParser()),
                       recommendationViewModel: RecommendationViewModel(recommendationParser: RecommendationParser()))
    }
}
