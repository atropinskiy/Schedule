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
            
            VStack() {
                ForEach(viewModel.stations, id: \.self) { station in
                    RowView(destination: station)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .padding(.horizontal, 0)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)


        
    }
}
