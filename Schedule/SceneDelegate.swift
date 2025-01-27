//
//  SceneDelegate.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let tabBarView = TabBarView()

            window.rootViewController = UIHostingController(rootView: tabBarView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

