//
//  WelcomeView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var userObserver: UserObserver
  @ObservedObject var workoutsObserver: WorkoutsObserver
  @ObservedObject var exercisesObserver: ExercisesObserver
  @ObservedObject var workoutObserver: WorkoutObserver
  @ObservedObject var analyticsObserver: AnalyticsObserver
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        
        Text("Fitnetic")
        .font(Font(UIFont(name: "SirinStencil-Regular", size: 70)!))
        .fontWeight(.black)
        .foregroundColor(.white)
        .padding(.bottom, 10)
        Text(verbatim: "Your personal fitness app.")
        .font(.headline)
          .foregroundColor(.white)
        
        Spacer()
        
        NavigationLink(destination: SignUpView(userObserver: self.userObserver)) {
          VStack {
            HStack {
              VStack {
                Text(verbatim: "Sign Up")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(.white)
                  .padding(.bottom, 5)
                Text(verbatim: "Create a new account.")
                  .font(.caption)
                  .foregroundColor(.white)
                  .lineLimit(3)
              }
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
              .layoutPriority(100)
              Spacer()
            }
          }
        }
        
        Divider()
        .padding(.vertical, 20)
        .padding(.horizontal, 80)
        
        Button(action: {
          let demoUserID: String = "5dbf3ac810fe5000041aef80"
          UserDefaults.standard.set(demoUserID, forKey: "globalUserID")
          
          self.userObserver.fetchData()
          self.workoutsObserver.fetchData()
          self.workoutObserver.fetchData()
          self.exercisesObserver.fetchData()
          self.analyticsObserver.fetchData()
          
          self.presentationMode.wrappedValue.dismiss()
        }) {
          VStack {
            HStack {
              VStack {
                Text(verbatim: "Sign In")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(.white)
                  .padding(.bottom, 10)
                Text(verbatim: "Use an existing account.")
                .font(.caption)
                .foregroundColor(.white)
                .lineLimit(3)
              }
            }
          }
        }
        
        Spacer()
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
      .edgesIgnoringSafeArea(.all)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

//struct WelcomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    WelcomeView(userObserver: UserObserver())
//  }
//}
