//
//  ContentView.swift
//
//  Created by alex_tr on 27.12.2024.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    
    @StateObject var viewModel = ScheduleViewModel()
    @State private var showDetailView = false
    
    @State private var stations: [Components.Schemas.Station] = []
    @State private var copyRight: Components.Schemas.Copyright?
    
    private let client: Client
    private let service: NetworkServiceProtocol
    
    init() {
        do {
            let url = try Servers.Server1.url()
            client = Client(serverURL: url, transport: URLSessionTransport())
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 0
            configuration.timeoutIntervalForResource = 0
            
            self.service = NetworkService(client: client, apikey: Constants.token)
        } catch {
            fatalError("Не удалось получить URL для сервера: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                // Горизонтальная прокрутка для картинок
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        ForEach(viewModel.story) { story in
                            Image(story.name)
                                .resizable() // Разрешаем изменение размера изображения
                                .scaledToFit() // Сохраняем соотношение сторон
                                .frame(height: 140) // Задаем фиксированную высоту
                        }
                    }
                }
                .padding(.top, 24)
                .frame(height: 188)
                
                // NavigationView для кнопок
                
                VStack(spacing: 16) {
                    // Кнопка "Откуда"
                    ZStack {
                        HStack (spacing: 16) {
                            VStack(spacing: 0) {
                                let city = viewModel.selectedCityFrom?.name
                                let station = viewModel.selectedStationFrom?.name
                                let fromText = (city != nil && station != nil) ? "(\(city ?? "")) \(station ?? "")" : "Откуда"
                                NavigationLink(destination: CitySelectionView(viewModel: viewModel, field: "from")) {
                                    Text(fromText)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 48)
                                        .foregroundColor(.gray)  // Цвет текста на кнопке
                                        .font(.system(size: 17, weight: .medium))
                                    
                                }
                                let cityTo = viewModel.selectedCityTo?.name
                                let stationTo = viewModel.selectedStationTo?.name
                                let fromTextTo = (cityTo != nil && stationTo != nil) ? "(\(cityTo ?? "")) \(stationTo ?? "")" : "Куда"
                                NavigationLink(destination: CitySelectionView(viewModel: viewModel , field: "to")) {
                                    Text(fromTextTo)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 48)
                                        .foregroundColor(.gray)  // Цвет текста на кнопке
                                        .font(.system(size: 17, weight: .medium))
                                    
                                }
                            }
                            
                            .frame(height: 98)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(20)
                            
                            Button(action: {
                                let tempCity = viewModel.selectedCityFrom
                                let tempStation = viewModel.selectedStationFrom
                                viewModel.selectedCityFrom = viewModel.selectedCityTo
                                viewModel.selectedStationFrom = viewModel.selectedStationTo
                                viewModel.selectedCityTo = tempCity
                                viewModel.selectedStationTo = tempStation
                            }) {
                                Image("swapButton")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 24, height: 24)
                            }
                            .frame(width: 36, height: 36)
                            .background()
                            .cornerRadius(40)
                        }
                        .background(Color.blue)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 128)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.top, 20)
                    
                    NavigationLink(destination: CarrierView(viewModel: viewModel)) {
                        Text("Найти")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 150, height: 60)
                            .background(Color.blue)
                            .cornerRadius(16)
                        //                        .disabled(viewModel.selectedStationFrom == nil || viewModel.selectedStationTo == nil)
                        //                    .opacity((viewModel.selectedStationFrom != nil && viewModel.selectedStationTo != nil) ? 1 : 0)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

