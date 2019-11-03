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
    
    var body: some View {
        TabView(selection: $selectedView) {
            WorkoutView()
                .tabItem {
                    Image(systemName: "play")
                    Text("Workout")
                }.tag(0)
            AnalyticsView()
                .tabItem {
                    Image(systemName: "date")
                    Text("Analytics")
                }.tag(1)
            ProfileView()
                .tabItem {
                    Image(systemName: "contact")
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
