//
//  AnalyticsView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Text("hello world")
            }
            .navigationBarTitle("Analytics", displayMode: .large)
            .background(bgColor)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
