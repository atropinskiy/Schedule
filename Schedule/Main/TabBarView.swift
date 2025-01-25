//
//  TabBarView.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTabIndex = 0

    var body: some View {
        TabView(selection: $selectedTabIndex) {
            ContentView()
                .tabItem {
                    Image("scheduleTab")
                    .renderingMode(.template)
                    .foregroundColor(selectedTabIndex == 0 ? .black : .gray)
                }
                .tag(0)
                
            Text("Вторая вкладка")
                .tabItem {
                    Image("settingsTab")
                    .renderingMode(.template)
                    .foregroundColor(selectedTabIndex == 1 ? .black : .gray)
                }
                .tag(1)
        }
        .accentColor(.black)
    }
}
