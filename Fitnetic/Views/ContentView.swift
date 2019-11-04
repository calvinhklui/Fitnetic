//
//  ContentView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selectedView = 0
    @State var workouts = WorkoutsParser().getWorkouts()
    @State var user = UserParser().getUser()
    
    var body: some View {
        TabView(selection: $selectedView) {
            WorkoutView()
                .tabItem {
                    Image(systemName: "square.fill")
                    Text("Workout")
                }.tag(0)
            AnalyticsView()
                .tabItem {
                    Image(systemName: "square.fill")
                    Text("Analytics")
                }.tag(1)
            ProfileView()
                .tabItem {
                    Image(systemName: "square.fill")
                    Text("Profile")
                }.tag(2)
        }
        .edgesIgnoringSafeArea(.top)
        .statusBar(hidden: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
