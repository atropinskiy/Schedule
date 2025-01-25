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
    private var field: String?
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
       
    init(viewModel: ScheduleViewModel, field: String) {
        self.viewModel = viewModel
        self.field = field
    }
    
    var placeholder = "Введите запрос"
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                SearchBar(searchText: $searchString)
                    .padding(.bottom, 16)
                
                List(viewModel.stations, id: \.self) { station in
                    
                    RowView(destination: station)
                        .listRowInsets(EdgeInsets())
                        .background(EmptyView())
                        .onTapGesture {
                            field == "from" ? (viewModel.selectedStationFrom = station) : (viewModel.selectedStationTo = station)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                .listStyle(.plain)
                .padding(0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}
