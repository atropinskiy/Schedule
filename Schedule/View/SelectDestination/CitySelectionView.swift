//
//  DestinationView.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI
struct CitySelectionView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var searchString = ""
    @State private var isTabBarHidden: Bool = true
    private var field: String
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: ScheduleViewModel, field: String) {
        self.viewModel = viewModel
        self.field = field
    }
    
    var body: some View {
        VStack(spacing:0) {
            SearchBar(searchText: $searchString)
                .padding(.bottom, 16)
            ScrollView {
                VStack(spacing:0) {
                    ForEach(viewModel.towns, id: \.self) { city in
                        NavigationLink(destination: StationSelectionView(viewModel: viewModel, field: field, city: city)) {
                            RowView(destination: city)
                        }
                    }
                }
                .padding(.horizontal, 0)
            }
            .navigationTitle("Выбор города")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                // Скрыть таб-бар при появлении экрана
                isTabBarHidden = true
            }
            .onDisappear {
                // Показать таб-бар при уходе с экрана
                isTabBarHidden = false
            }
            .toolbar(isTabBarHidden ? .hidden : .visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color("AT-black-DN"))
                            .padding(.horizontal, 0)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct CitySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScheduleViewModel()
        return CitySelectionView(viewModel: viewModel, field: "from")
    }
}


