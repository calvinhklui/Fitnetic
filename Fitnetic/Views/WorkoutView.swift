//
//  WorkoutView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WorkoutView: View {
    init() {
        UINavigationBar.appearance().backgroundColor = primaryUIColor
         UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                TodayView()
                Spacer()
            }
            .navigationBarTitle("Workout", displayMode: .large)
            .background(bgColor)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
