//
//  EditProfileView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/8/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
  @State private var username: String = ""
  @State private var firstName: String = ""
  @State private var lastName: String = ""
  @State private var genderSelection = 0
  @State private var genders = ["Female", "Male"]
  @State private var birthDate = Date()
  @State private var goal: String = ""
  
  @State private var showingAlert = false
  
  @ObservedObject var userObserver: UserObserver
  
  init(userObserver: UserObserver) {
    self.userObserver = userObserver
    
    self.username = userObserver.user.username
    self.firstName = userObserver.user.firstName
    self.lastName = userObserver.user.lastName
    self.genderSelection = userObserver.user.gender == "Female" ? 0 : 1
    
    let oldDate = userObserver.user.dateOfBirth.replacingOccurrences(of: ".", with: "+")
    let dateFormatterISO8601 = ISO8601DateFormatter()
    self.birthDate = dateFormatterISO8601.date(from: oldDate) ?? Date()
    
    self.goal = userObserver.user.goal
  }
  
  var body: some View {
    VStack {
        Section {
          TextField(self.userObserver.user.username, text: $username)
          TextField(self.userObserver.user.firstName, text: $firstName)
          TextField(self.userObserver.user.lastName, text: $lastName)
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
          TextField(self.userObserver.user.goal, text: $goal)
        }
      
      Button(action: {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        let dateText = dateFormatter.string(from: self.birthDate)
        
        let newUser = User(
          id: self.userObserver.user.id,
          username: self.username,
          firstName: self.firstName,
          lastName: self.lastName,
          dateOfBirth: dateText,
          gender: self.genders[self.genderSelection],
          goal: self.goal
        )
        
        self.userObserver.setUser(newUser)
        self.userObserver.updateData()
        self.showingAlert = true
      }) {
        Text("Update")
          .font(.title)
          .fontWeight(.black)
          .foregroundColor(.primary)
          .padding(.bottom, 5)
      }
      .alert(isPresented: $showingAlert) {
          Alert(title: Text("Profile Updated"), message: Text("You're good to go!"), dismissButton: .default(Text("Okay")))
      }
    }
    .navigationBarTitle("Profile")
  }
}

//struct EditProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    EditProfileView()
//  }
//}

