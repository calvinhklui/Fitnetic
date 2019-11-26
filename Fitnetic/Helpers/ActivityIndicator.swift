//
//  ActivityIndicator.swift
//  Fitnetic
//
//  Created by Calvin Lui on 11/26/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

// Source: https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
