//
//  AppDelegate.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: TabBarView())
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

