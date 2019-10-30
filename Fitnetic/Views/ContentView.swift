//
//  ContentView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().barTintColor = primaryUIColor
    }
    
    @State var selectedView = 0
    
    var body: some View {
        TabView(selection: $selectedView) {
            WorkoutView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Workout")
                }.tag(0)
            AnalyticsView()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Analytics")
                }.tag(1)
            ProfileView()
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Profile")
                }.tag(2)
        }
        //.edgesIgnoringSafeArea(.all)
        .statusBar(hidden: false)
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
