//
//  DestinationView.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI

struct CitySelectionView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var countrySelected = false
    @State private var searchString = ""
    private var destinationType: String = "Выбор города"
    private var field: String?
       
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
                
                List(viewModel.towns, id: \.self) { town in
                    Button(action: {
                        field == "from" ? (viewModel.selectedCityFrom = town) : (viewModel.selectedCityTo = town)
                        countrySelected = true
                    }) {
                        RowView(destination: town)
                            .listRowInsets(EdgeInsets())
                            .background(EmptyView())

                    }
                }
                .listStyle(.plain)
                .padding(0)
                .navigationDestination(isPresented: $countrySelected) {
                    if let validField = field {
                        StationSelectionView(viewModel: viewModel, field: validField)
                    } else {
                        Text("Поле не указано")
                    }
                    
                }
                
            }
        }
    }
}

struct CitySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScheduleViewModel()
        return CitySelectionView(viewModel: viewModel, field: "from")
    }
}
