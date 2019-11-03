//
//  TodayView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/30/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
      VStack {
        HStack {
          VStack(alignment: .leading) {
            NavigationLink(destination: PreWorkoutView()) {
                VStack {
                    HStack {
                      VStack(alignment: .leading) {
                        Text("Today")
                              .font(.title)
                              .fontWeight(.black)
                              .foregroundColor(.primary)
                        Text("Back, Biceps, & Abs")
                              .font(.caption)
                              .foregroundColor(.secondary)
                              .lineLimit(3)
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
            
            NavigationLink(destination: PreWorkoutView()) {
                VStack {
                    HStack {
                      VStack(alignment: .leading) {
                        Text("Past Workouts")
                              .font(.title)
                              .fontWeight(.black)
                              .foregroundColor(.primary)
                        Text("Explore your history.")
                              .font(.caption)
                              .foregroundColor(.secondary)
                              .lineLimit(3)
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
            
            NavigationLink(destination: PreWorkoutView()) {
                VStack {
                    HStack {
                      VStack(alignment: .leading) {
                        Text("Build Your Own Workout")
                              .font(.title)
                              .fontWeight(.black)
                              .foregroundColor(.primary)
                        Text("Unleash your creativity.")
                              .font(.caption)
                              .foregroundColor(.secondary)
                              .lineLimit(3)
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
          }
          .layoutPriority(100)
          Spacer()
        }
        .padding(20)
      }
      .background(Color.white)
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
