//
//  SettingsViewModel.swift
//  Schedule
//
//  Created by alex_tr on 22.02.2025.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var isDarkMode: Bool = false {
        didSet {
            updateUserInterfaceStyle()
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode") // ✅ Читаем значение при инициализации
        updateUserInterfaceStyle()
    }
    
    func updateUserInterfaceStyle() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else { return }
        
        window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
}

