//
//  DestinationView.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI

struct StationSelectionView: View {
    @ObservedObject private var viewModel: ScheduleViewModel
    @EnvironmentObject var destinationViewModel: DestinationViewModel
    @State private var searchString = ""
    @State private var isTabBarHidden: Bool = true
    @Environment(\.dismiss) private var dismiss
    private var field: String
    private var city: Destinations
    
    init(viewModel: ScheduleViewModel, field: String, city: Destinations) {
        self.viewModel = viewModel
        self.field = field
        self.city = city
    }
    
    private var filteredStations: [Destinations] {
        if searchString.isEmpty {
            return destinationViewModel.stations
        } else {
            return destinationViewModel.stations.filter { $0.name.localizedCaseInsensitiveContains(searchString) }
        }
    }
    
    var body: some View {
        VStack (spacing: 0) {
            SearchBar(searchText: $searchString)
                .padding(.bottom, 16)
            ZStack {
                if filteredStations.isEmpty {
                    // Заглушка, если городов нет
                    VStack {
                        Text("Вариантов нет")
                            .font(.system(size: 25, weight: .bold))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(spacing:0) {
                            ForEach(filteredStations, id: \.self) { station in
                                RowView(destination: station)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if field == "from" {
                                            viewModel.selectedStationFrom = station
                                            viewModel.selectedCityFrom = city
                                        } else {
                                            viewModel.selectedStationTo = station
                                            viewModel.selectedCityTo = city
                                        }
                                        viewModel.removeAll()
                                    }
                            }
                            .padding(0)
                        }
                    }
                }
            }
            .navigationTitle("Выбор станции")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                isTabBarHidden = true
                destinationViewModel.getStations(for: city.name)
            }
            .onDisappear {
                isTabBarHidden = false
            }
            .toolbarBackground(Color("AT-black-DN"), for: .navigationBar)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 16)
        
    }
}
