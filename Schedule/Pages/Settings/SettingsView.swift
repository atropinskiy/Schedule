//
//  SettingsView.swift
//  Schedule
//
//  Created by alex_tr on 27.01.2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                HStack {
                    Text("Темная тема")
                        .font(.system(size: 17, weight: .regular))
                    Spacer()
                    Toggle(isOn: $viewModel.isDarkMode) {
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .frame(height: 60)
                .padding(.leading, 16)
                .padding(.trailing, 14.5)
                NavigationLink(destination: AgreementView()) {
                    HStack {
                        Text("Пользовательское соглашение")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(Color("AT-black-DN"))
                        Spacer()
                        
                        Image("navArrow")
                            .renderingMode(.template)
                            .foregroundColor(Color("AT-black-DN"))
                    }
                }
                .frame(height: 60)
                .padding(.leading, 16)
                .padding(.trailing, 14.5)
                Spacer()
                VStack(spacing: 16) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("AT-black-DN"))
                    Text("Версия 1.0 (beta)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("AT-black-DN"))
                }
            }
            .padding(.vertical, 24)
        }
    }
}

#Preview {
    SettingsView()
}
