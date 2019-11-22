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
      Spacer()
      IdentityView(userObserver: self.userObserver)
      Spacer()
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
      .frame(height: 300)
      .padding(.bottom, 70)
      
      Spacer()
      
      Button(action: {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        let dateText = dateFormatter.string(from: self.birthDate)
        
        let updatedUser = User(
          id: self.userObserver.user.id,
          username: self.username,
          firstName: self.firstName,
          lastName: self.lastName,
          dateOfBirth: dateText,
          gender: self.genders[self.genderSelection],
          goal: self.goal
        )
        
        self.userObserver.setUser(updatedUser)
        self.userObserver.updateData()
        self.showingAlert = true
      }) {
        GeometryReader { geometry in
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
          .frame(width: geometry.size.width)
          .padding(.horizontal, 30)
          .padding(.vertical, 15)
          .foregroundColor(.primary)
          .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
          .cornerRadius(10)
          .padding(.top, 5)
        }
        .padding(.horizontal, 50)
      }
      .alert(isPresented: $showingAlert) {
        Alert(title: Text("Changes Saved"), message: Text("Refresh the page to view your updated profile."), dismissButton: .default(Text("Cool")))
      }
    }
  }
}

//struct EditProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    EditProfileView()
//  }
//}

