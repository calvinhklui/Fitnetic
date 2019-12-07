//
//  EditProfileView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/8/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State private var username: String = ""
  @State private var firstName: String = ""
  @State private var lastName: String = ""
  @State private var genderSelection = 0
  @State private var genders = ["Female", "Male"]
  @State private var birthDate = Date()
  @State private var goal: String = ""
  
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
    ScrollView {
      IdentityView(userObserver: self.userObserver, showDetails: false)
      .padding(.top, 50)
      
      Spacer()
      Form {
        Section (header: Text(verbatim: "Profile Information")) {
          HStack {
            Text("Username")
            .font(.system(size: 12))
            .foregroundColor(Color(UIColor.systemGray2))
            Spacer()
            TextField(self.userObserver.user.username, text: $username)
            .foregroundColor(Color(UIColor.systemGray2))
            .frame(width: 200)
          }
          .disabled(true)
          
          HStack {
            Text("First Name")
            .font(.system(size: 12))
            .foregroundColor(Color(UIColor.systemGray2))
            Spacer()
            TextField(self.userObserver.user.firstName, text: $firstName)
            .frame(width: 200)
          }
          
          HStack {
            Text("Last Name")
            .font(.system(size: 12))
            .foregroundColor(Color(UIColor.systemGray2))
            Spacer()
            TextField(self.userObserver.user.lastName, text: $lastName)
            .frame(width: 200)
          }
          
          HStack {
            Text("Gender")
            .font(.system(size: 12))
            .foregroundColor(Color(UIColor.systemGray2))
            Spacer()
            Picker(selection: $genderSelection, label: Text("Gender")) {
              ForEach(0 ..< genders.count) {
                Text(self.genders[$0]).tag($0)
              }
            }.pickerStyle(SegmentedPickerStyle())
            .frame(width: 200)
          }
          
          DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
            Text("Date of Birth")
            .font(.system(size: 12))
            .foregroundColor(Color(UIColor.systemGray2))
          }
          
          HStack {
            Text("Goal")
            .font(.system(size: 12))
            .foregroundColor(Color(UIColor.systemGray2))
            Spacer()
            TextField(self.userObserver.user.goal, text: $goal)
            .frame(width: 200)
          }
        }
      }
      .frame(height: 300)
      
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
        self.userObserver.updateData(completion: { (success) -> Void in
          if success {
            self.userObserver.fetchData()
            self.presentationMode.wrappedValue.dismiss()
          }
        })
      }) {
        GeometryReader { geometry in
          VStack {
            HStack {
              VStack {
                if (self.userObserver.loading) {
                  ActivityIndicator(isAnimating: .constant(true), style: .medium)
                } else {
                  Text(verbatim: "Save")
                  .font(.title)
                  .fontWeight(.black)
                  .foregroundColor(Color(UIColor.white))
                }
              }
            }
          }
          .frame(width: geometry.size.width)
          .padding(.horizontal, 30)
          .padding(.vertical, 15)
          .foregroundColor(.primary)
          .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemIndigo)]), startPoint: .top, endPoint: .bottom))
          .cornerRadius(10)
        }
        .padding(.horizontal, 50)
        .frame(height: 50)
      }
      .padding(.vertical, 15)
    }
    .onAppear(perform: {
      self.username = self.userObserver.user.username
      self.firstName = self.userObserver.user.firstName
      self.lastName = self.userObserver.user.lastName
      self.genderSelection = self.userObserver.user.gender == "Female" ? 0 : 1
      
      let oldDate = self.userObserver.user.dateOfBirth.replacingOccurrences(of: ".", with: "+")
      let dateFormatterISO8601 = ISO8601DateFormatter()
      self.birthDate = dateFormatterISO8601.date(from: oldDate) ?? Date()
      
      self.goal = self.userObserver.user.goal
    })
  }
}

//struct EditProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    EditProfileView()
//  }
//}

