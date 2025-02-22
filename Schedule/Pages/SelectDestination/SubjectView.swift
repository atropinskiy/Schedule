//
//  DestinationView.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI

struct SubjectView: View {
    @StateObject var viewModel = ScheduleViewModel()
    @State private var searchString = ""
    @State var selectedDestination = Set<Destinations.ID>()
    private var destinationType: String
    
    init (destinationType: String) {
        self.destinationType = destinationType
    }
    var placeholder = "Введите запрос"
    var body: some View {
            VStack (spacing: 0) {
                Text(destinationType)
                    .font(.system(size: 17, weight: .bold))
                    .frame(height: 42)
                    .frame(alignment: .top)
                SearchBar(searchText: $searchString)
                    .padding(.bottom, 16)
                List(viewModel.towns, id: \.self) { town in
                        RowView(destination: town)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    
                }
                .listStyle(.plain)
                
                .padding(0)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


#Preview {
    DestinationView(destinationType: "Выбор станции", destinations: [Destinations(name: "Moscow")])
}
