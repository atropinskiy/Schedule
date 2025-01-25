//
//  CarrierView.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct CarrierView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var selectedCarrier: CarrierModel? = nil
    private var stationFrom: String?
    private var stationTo: String?
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack (spacing: 16){
                    Text("\(stationFrom ?? "StationFrom") -> \(stationTo ?? "StationTo")")
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
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
                        .listRowInsets(EdgeInsets())
                    }
                    
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 0)
                    .padding(.top, 16)
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
        }
    }
}

struct CarrierView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScheduleViewModel()
        return CarrierView(viewModel: viewModel)
    }
}
