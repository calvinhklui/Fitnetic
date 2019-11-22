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
          VStack (alignment: .leading) {
            Text("Username").font(.headline)
            TextField("", text: $username)
          }
          
          VStack (alignment: .leading) {
            Text("First Name").font(.headline)
            TextField("", text: $firstName)
          }
          
          VStack (alignment: .leading) {
            Text("Last Name").font(.headline)
            TextField("", text: $lastName)
          }
          
          VStack (alignment: .leading) {
            Text("Gender").font(.headline)
            Picker(selection: $genderSelection, label: Text("Gender")) {
              ForEach(0 ..< genders.count) {
                Text(self.genders[$0]).tag($0)
              }
            }.pickerStyle(SegmentedPickerStyle())
          }
          
          VStack (alignment: .leading) {
            Text("Date of Birth").font(.headline)
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) { EmptyView() }
          }
          
          VStack (alignment: .leading) {
            Text("Goal").font(.headline)
            TextField(self.userObserver.user.goal, text: $goal)
          }
        }
      }
      .frame(height: 550)
      
      Spacer()
      
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
        }
        .padding(.horizontal, 50)
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
