//
//  HostingController.swift
//  Fitnetic
//
//  Created by Calvin Lui on 10/29/19.
//  Copyright © 2019 67-442. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

// Source: https://stackoverflow.com/questions/57063142/swiftui-status-bar-color
class HostingController: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
