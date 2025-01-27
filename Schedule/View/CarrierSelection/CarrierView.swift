//
//  CarrierView.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct CarrierView: View {
    @ObservedObject private var viewModel: ScheduleViewModel
    @State private var selectedCarrier: CarrierModel? = nil
    @State private var isTabBarHidden: Bool = true
    @Environment(\.dismiss) var dismiss
    private var stationFrom: String
    private var stationTo: String
    
    init(viewModel: ScheduleViewModel, destinationFrom: String, destinationTo: String) {
        self.viewModel = viewModel
        self.stationFrom = destinationFrom
        self.stationTo = destinationTo
    }
    
    var body: some View {
        ZStack {
            VStack (spacing: 16){
                Text("\(stationFrom) -> \(stationTo)")
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.carrierList.filter { carrier in
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
                        }, id: \.id) { carrier in
                            NavigationLink(destination: CarrierDetailsView(carrier: carrier.name)) {
                                CarrierCard(cardCarrier: carrier)
                            }
                            
                            
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        .zIndex(0)
                    }

                    .padding(.horizontal, 0)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
                .tint(.black)
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
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            
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
                .zIndex(1)  // Кнопка должна быть поверх других элементов
                .contentShape(Rectangle())
                
            }
            
        }
        .padding(.horizontal, 16)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(isTabBarHidden ? .hidden : .visible, for: .tabBar)
    }
}

struct CarrierView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScheduleViewModel()
        return CarrierView(viewModel: viewModel, destinationFrom: "Москва", destinationTo: "Яровславль")
    }
}
