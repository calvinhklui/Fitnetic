//
//  PreWorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/3/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct PreWorkoutView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
                Spacer()
                
//                List() {
//                    SetRowView(set: nil)
//                }
                
                Spacer()
                
                VStack {
                    HStack {
                      VStack(alignment: .leading) {
                        NavigationLink(destination: PreWorkoutView()) {
                            VStack {
                                HStack {
                                  VStack(alignment: .leading) {
                                    Text("Start")
                                          .font(.title)
                                          .fontWeight(.black)
                                          .foregroundColor(.primary)
                                  }
                                  .layoutPriority(100)
                                  Spacer()
                                }
                                .padding(20)
                            }
                        }
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.6), lineWidth: 1))
                        .padding(.bottom, 20)
                        }
                    }
                }
            }
            .navigationBarTitle("Workout", displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PreWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        PreWorkoutView()
    }
}
