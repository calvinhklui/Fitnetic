//
//  CameraView.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/19/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import SwiftUI

struct CameraView: View {
  var body: some View {
    JointViewController()
  }
}

// Source: https://github.com/owingst/SwiftUIScanner/blob/master/SwiftUIScanner/
extension JointViewController: UIViewControllerRepresentable {
  
  public typealias UIViewControllerType = JointViewController
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<JointViewController>) -> JointViewController {
    return JointViewController()
  }
  
  func updateUIViewController(_ uiViewController: JointViewController, context: UIViewControllerRepresentableContext<JointViewController>) {
  }
}
