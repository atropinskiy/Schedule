//
//  SceneDelegate.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let destinationViewModel = DestinationViewModel()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let contentView = TabBarView()
            .environmentObject(destinationViewModel)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
        Task {
            await destinationViewModel.getStationList()
        }
    }
}

