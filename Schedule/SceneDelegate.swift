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
    let settingsViewModel = SettingsViewModel() // ✅ Добавили ViewModel для темы

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let contentView = TabBarView()
            .environmentObject(destinationViewModel)
            .environmentObject(settingsViewModel) // ✅ Передаем тему в SwiftUI

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
        window.overrideUserInterfaceStyle = settingsViewModel.isDarkMode ? .dark : .light // ✅ Применяем тему

        self.window = window
        window.makeKeyAndVisible()

        Task {
            await destinationViewModel.getStationList()
        }
    }
}

