//
//  ProfileView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  @State var showEditScreen: Bool = false
  
  @ObservedObject var userObserver: UserObserver
  
  var age: Int = 0
  
  init(userObserver: UserObserver) {
    self.userObserver = userObserver
    
    // format workout date for display
    let oldDate = userObserver.user.dateOfBirth.replacingOccurrences(of: ".", with: "+")
    
    let dateFormatterISO8601 = ISO8601DateFormatter()
    let date = dateFormatterISO8601.date(from: oldDate)
    
    if let date = date {
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "en_US")
      dateFormatter.setLocalizedDateFormatFromTemplate("yyyy")
      age = Int(dateFormatter.string(from: Date()))! - Int(dateFormatter.string(from: date))!
    }
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        Spacer()
        
        IdentityView(userObserver: self.userObserver, showDetails: true)
        
        Spacer()
        
        VStack {
          HStack {
            VStack(alignment: .leading) {
              Text(verbatim: "Age")
                .font(.caption)
                .foregroundColor(.secondary)
              Text(verbatim: "\(self.age)")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
            }
            
            Spacer()
          }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 40)
        .background(Color(UIColor.systemBackground))
        
        Spacer()
        
        VStack {
          HStack {
            VStack(alignment: .leading) {
              Text(verbatim: "Gender")
                .font(.caption)
                .foregroundColor(.secondary)
              Text(verbatim: "\(self.userObserver.user.gender)")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
            }
            
            Spacer()
          }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 40)
        .background(Color(UIColor.systemBackground))
        
        Spacer()
        
        VStack {
          HStack {
            VStack(alignment: .leading) {
              Text(verbatim: "Goal")
                .font(.caption)
                .foregroundColor(.secondary)
              Text(verbatim: "\(self.userObserver.user.goal)")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
            }
            
            Spacer()
          }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 40)
        .background(Color(UIColor.systemBackground))
      }
      .navigationBarTitle("Profile", displayMode: .large)
      .navigationBarItems(trailing:
        VStack {
          if (self.userObserver.loading) {
            ActivityIndicator(isAnimating: .constant(true), style: .medium)
          } else {
            Button(action: {
              self.showEditScreen = true
            }) {
              VStack {
                HStack {
                  VStack {
                    Image(systemName: "pencil.circle.fill")
                      .font(.title)
                      .foregroundColor(Color(UIColor.systemBlue))
                      .foregroundColor(.primary)
                  }
                }
              }
            }
          }
        }
      )
        .background(Color(UIColor.systemGray6))
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .popover(
      isPresented: self.$showEditScreen,
      arrowEdge: .bottom
    ) {
      ZStack {
        EditProfileView(userObserver: self.userObserver)
        
        VStack {
          HStack {
            Button(action: {
              self.showEditScreen = false
            }) {
              HStack {
                Image(systemName: "xmark.circle.fill")
                  .font(.title)
                  .foregroundColor(Color(UIColor.systemRed))
              }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
            
            Spacer()
          }
          Spacer()
        }
      }
    }
    .onAppear(perform: {
      self.userObserver.fetchData()
      self.showEditScreen = false
    })
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(userObserver: UserObserver())
  }
}
