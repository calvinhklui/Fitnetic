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
        Section {
          TextField("Username", text: $username)
          TextField("First Name", text: $firstName)
          TextField("Last Name", text: $lastName)
        }
        
        Section {
          HStack {
            Text("Gender")
            Spacer()
            Picker(selection: $genderSelection, label: Text("Gender")) {
              ForEach(0 ..< genders.count) {
                Text(self.genders[$0]).tag($0)
              }
            }.pickerStyle(SegmentedPickerStyle())
          }
          DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) { Text("Birth Date") }
        }
        
        Section {
          TextField("Goal", text: $goal)
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
        Text("Save")
          .font(.title)
          .fontWeight(.black)
          .foregroundColor(.primary)
          .padding(.bottom, 5)
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
