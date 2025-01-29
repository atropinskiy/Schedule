//
//  TabBarView.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @State private var selectedTabIndex = 0
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        TabView(selection: $selectedTabIndex) {
            if let errorType =  viewModel.showError {
                ErrorView(errorType: errorType)
                    .tabItem {
                        Image("scheduleTab")
                            .renderingMode(.template)
                            .foregroundColor(iconColor(for: 0))
                        Text("Schedule")
                    }
                    .tag(0)
            } else {
                ContentView(viewModel: viewModel)
                    .tabItem {
                        Image("scheduleTab")
                            .renderingMode(.template)
                            .foregroundColor(iconColor(for: 0))
                        Text("Schedule")
                    }
                    .tag(0)
            }
            if let errorType =  viewModel.showError {
                ErrorView(errorType: errorType)
                    .tabItem {
                        Image("scheduleTab")
                            .renderingMode(.template)
                            .foregroundColor(iconColor(for: 0))
                        Text("Schedule")
                    }
                    .tag(0)
            } else {
                SettingsView(viewModel: viewModel)
                    .tabItem {
                        Image("settingsTab")
                            .renderingMode(.template)
                            .foregroundColor(iconColor(for: 1))
                        Text("Settings")
                    }
                    .tag(1)
            }
        }
        .accentColor(Color("AT-black-DN"))
    }
    
    private func iconColor(for tabIndex: Int) -> Color {
        if selectedTabIndex == tabIndex {
            return colorScheme == .dark ? .white : Color("AT-black-DN")
        } else {
            return .gray
        }
    }
}
