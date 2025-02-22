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
            let timeCondition = viewModel.timeSelections.isEmpty ||
                viewModel.timeSelections.contains { $0.contains(viewModel.carrierInInterval(carrier: carrier)) }
            return transferCondition && timeCondition
        }
    }

    var body: some View {
        ZStack {
            if viewModel.isLoading && viewModel.carrierList.isEmpty {
                CarrierLoadingView()
            } else {
                VStack(spacing: 16) {
                    CarrierHeaderView(destinationFrom: destinationFrom, destinationTo: destinationTo)
                    CarrierListView(filteredCarriers: filteredCarriers, viewModel: viewModel, stationFrom: stationFrom, stationTo: stationTo)
                        .padding(.horizontal, 0)
                        
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 0)
                
            }

            FilterButtonView()
        }
        .padding(.bottom, 24)
        .padding(.horizontal, 16)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("AT-black-DN"))
                        .padding(.horizontal, 0)
                }
            }
        }
        .toolbar(isTabBarHidden ? .hidden : .visible, for: .tabBar)
        .task {
            await viewModel.getCarriers(stationFrom: stationFrom, stationTo: stationTo)
        }
    }
}

// MARK: - Заголовок с направлением
private struct CarrierHeaderView: View {
    let destinationFrom: String
    let destinationTo: String

    var body: some View {
        Text("\(destinationFrom) -> \(destinationTo)")
            .font(.system(size: 24, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
    }
}

// MARK: - Список перевозчиков
private struct CarrierListView: View {
    let filteredCarriers: [CarrierModel]
    let viewModel: CarrierViewModel
    let stationFrom: Destinations
    let stationTo: Destinations

    var body: some View {
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
                    ForEach(filteredCarriers) { carrier in
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
}

// MARK: - Индикатор загрузки
private struct CarrierLoadingView: View {
    var body: some View {
        VStack {
            ProgressView("Загрузка...")
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.8)) // Полупрозрачный фон
    }
}

// MARK: - Кнопка "Уточнить время"
private struct FilterButtonView: View {
    var body: some View {
        VStack {
            Spacer()
            NavigationLink(destination: FilterView(viewModel: CarrierViewModel())) {
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
