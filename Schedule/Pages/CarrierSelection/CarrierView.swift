//
//  CarrierView.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct CarrierView: View {
    @StateObject private var viewModel = CarrierViewModel()
    @State private var selectedCarrier: CarrierModel? = nil
    @State private var isTabBarHidden: Bool = true
    @Environment(\.dismiss) var dismiss
    private var destinationFrom: String
    private var destinationTo: String
    private var stationFrom: Destinations
    private var stationTo: Destinations
    
    init(
        destinationFrom: String,
        destinationTo: String,
        stationFrom: Destinations,
        stationTo: Destinations
    ) {
        self.destinationFrom = destinationFrom
        self.destinationTo = destinationTo
        self.stationFrom = stationFrom
        self.stationTo = stationTo
    }
    
    
    private var filteredCarriers: [CarrierModel] {
        viewModel.carrierList.filter { carrier in
            let transferCondition = (viewModel.transferFlag ?? true) ? true : (carrier.transfer?.isEmpty ?? true)
            
            let timeCondition: Bool
            if !viewModel.timeSelections.isEmpty {
                let carrierInterval = viewModel.carrierInInterval(carrier: carrier)
                print(carrierInterval)
                timeCondition = viewModel.timeSelections.contains { selectedInterval in
                    selectedInterval.contains(carrierInterval)
                }
            } else {
                timeCondition = true
            }
            
            return transferCondition && timeCondition
        }
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading && viewModel.carrierList.isEmpty {
                VStack {
                    ProgressView("Загрузка...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.8)) // Полупрозрачный фон, если нужно
            } else {
                VStack(spacing: 16) {
                    Text("\(destinationFrom) -> \(destinationTo)")
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)

                    if filteredCarriers.isEmpty {
                        VStack {
                            Text("Вариантов нет")
                                .font(.system(size: 25, weight: .bold))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom, 60)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(filteredCarriers, id: \.id) { carrier in
                                    NavigationLink(destination: CarrierDetailsView(viewModel: viewModel, carrier: carrier.carrierCode)) {
                                        CarrierCard(cardCarrier: carrier)
                                    }
                                    .onAppear {
                                        if carrier == filteredCarriers.last {
                                            Task {
                                                await viewModel.getCarriers(stationFrom: stationFrom, stationTo: stationTo)
                                            }
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .zIndex(0)

                                if viewModel.isLoading {
                                    ProgressView("Загрузка...")
                                        .padding()
                                }
                            }
                        }
                        .padding(.horizontal, 0)
                        .scrollIndicators(.hidden)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 16)
            }

            VStack {
                Spacer()
                NavigationLink(destination: FilterView(viewModel: viewModel)) {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color("AT-blue"))
                        .cornerRadius(16)
                }
                .zIndex(1)
                .contentShape(Rectangle())
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 0)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(isTabBarHidden ? .hidden : .visible, for: .tabBar)
        .task {
            await viewModel.getCarriers(stationFrom: self.stationFrom, stationTo: self.stationTo)
        }
    }

}

struct CarrierView_Previews: PreviewProvider {
    static var previews: some View {
        CarrierView(
            destinationFrom: "Москва",
            destinationTo: "Санкт-Петербург",
            stationFrom: Destinations(name: "Ленинградский вокзал", stationId: "c234"),
            stationTo: Destinations(name: "Московский вокзал", stationId: "c213")
        )
    }
}
