//
//  SignUpView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/7/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State private var username: String = ""
  @State private var firstName: String = ""
  @State private var lastName: String = ""
  @State private var genderSelection = 0
  @State private var genders = ["Female", "Male"]
  @State private var birthDate = Date()
  @State private var goal: String = ""
  
  @ObservedObject var userObserver: UserObserver
  
  var body: some View {
    VStack {
      Form {
        Section (header: Text(verbatim: "Profile Information")) {
          HStack {
            Text("Username")
            Spacer()
            TextField(self.userObserver.user.username, text: $username)
          }
          
          HStack {
            Text("First Name")
            Spacer()
            TextField(self.userObserver.user.firstName, text: $firstName)
          }
          
          HStack {
            Text("Last Name")
            Spacer()
            TextField(self.userObserver.user.lastName, text: $lastName)
          }
        
          HStack {
            Text("Gender")
            Spacer()
            Picker(selection: $genderSelection, label: Text("Gender")) {
              ForEach(0 ..< genders.count) {
                Text(self.genders[$0]).tag($0)
              }
            }.pickerStyle(SegmentedPickerStyle())
          }
          
          DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) { Text("Date of Birth") }
          
          HStack {
            Text("Goal")
            Spacer()
            TextField(self.userObserver.user.goal, text: $goal)
          }
        }
      }
      
      Button(action: {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        let dateText = dateFormatter.string(from: self.birthDate)
        
        let newUser = User(
          id: "abcde123",
          username: self.username,
          firstName: self.firstName,
          lastName: self.lastName,
          dateOfBirth: dateText,
          gender: self.genders[self.genderSelection],
          goal: self.goal
        )
        
        self.userObserver.setUser(newUser)
        self.userObserver.postData()
        
        self.presentationMode.wrappedValue.dismiss()
      }) {
        VStack {
          HStack {
            VStack {
              Text(verbatim: "Save")
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
    }
    .navigationBarTitle("Sign Up")
  }
}

//struct SignUpView_Previews: PreviewProvider {
//  static var previews: some View {
//    SignUpView()
//  }
//}
