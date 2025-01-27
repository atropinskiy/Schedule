//
//  DestinationView.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI

struct StationSelectionView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var searchString = ""
    @State private var isTabBarHidden: Bool = true
    @Environment(\.dismiss) var dismiss
    private var field: String
    private var city: Destinations
    
    init(viewModel: ScheduleViewModel, field: String, city: Destinations) {
        self.viewModel = viewModel
        self.field = field
        self.city = city
    }
    
    var placeholder = "Введите запрос"
    
    var body: some View {
        VStack (spacing: 0) {
            SearchBar(searchText: $searchString)
                .padding(.bottom, 16)
            ScrollView {
                VStack(spacing:0) {
                    ForEach(viewModel.stations, id: \.self) { station in
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
                .navigationTitle("Выбор станции")
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    isTabBarHidden = true
                }
                .onDisappear {
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
                .toolbarBackground(Color("AT-black-DN"), for: .navigationBar)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 16)


        
    }
}
