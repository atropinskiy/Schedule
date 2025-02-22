//
//  SettingsViewModel.swift
//  Schedule
//
//  Created by alex_tr on 22.02.2025.
//

import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var isDarkMode: Bool = false {
        didSet {
            updateUserInterfaceStyle()
        }
    }
    
    private func updateUserInterfaceStyle() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}

