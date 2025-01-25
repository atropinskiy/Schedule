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
                    Text("\(stationFrom) -> \(stationTo)")
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(viewModel.carrierList.filter { carrier in
                                // Фильтрация по transferFlag
                                let transferCondition = (viewModel.transferFlag ?? true) ? true : (carrier.transfer?.isEmpty ?? true)
                                
                                // Фильтрация по времени
                                let timeCondition: Bool
                                if !viewModel.timeSelections.isEmpty {
                                    let carrierInterval = viewModel.carrierInInterval(carrier: carrier)
                                    print(carrierInterval)
                                    timeCondition = viewModel.timeSelections.contains { selectedInterval in
                                        selectedInterval.contains(carrierInterval)
                                    }
                                } else {
                                    timeCondition = true  // Если timeSelections пуст, не фильтруем по времени
                                }
                                
                                // Возвращаем, если выполняются оба условия
                                return transferCondition && timeCondition
                            }, id: \.id) { carrier in
                                Button(action: {
                                    selectedCarrier = carrier
                                }) {
                                    CarrierCard(cardCarrier: carrier)
                                }
                                .buttonStyle(PlainButtonStyle()) // Сохраняем стиль карточек
                                .navigationDestination(isPresented: .constant(selectedCarrier != nil)) {
                                    if let carrier = selectedCarrier {
                                        CarrierDetailsView(carrier: carrier.name)
                                    }
                                }
                                .zIndex(0)
                                
                                
                            }
                            .padding(.horizontal, 0)
                            .listRowInsets(EdgeInsets())
                        }
                        
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding(.horizontal, 16)
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
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                }
            }
        }
        }
    }
    
    struct CarrierView_Previews: PreviewProvider {
        static var previews: some View {
            let viewModel = ScheduleViewModel()
            return CarrierView(viewModel: viewModel)
        }
    }
