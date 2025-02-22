//
//  CitySelectionViewModel.swift
//  Schedule
//
//  Created by alex_tr on 20.02.2025.
//

import SwiftUI
import Combine

@MainActor
class DestinationViewModel: ObservableObject {
    @Published var destinations: ResponseDestination?
    @Published var errorMessage: String?
    @Published var cities: [Destinations]?
    @Published var stations: [Destinations] = []
    @Published var isLoading = false
    private var networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()

    
    
    func getStationList() async {
        isLoading = true
        let decoder = JSONDecoder()
        
        do {
            // Получаем данные с сервера через networkService
            let result = try await networkService.getStationsList()  // Предположим, что это возвращает Data или строку в формате JSON
            
            // Если получен результат в виде строки, нужно привести его к Data
            guard let jsonData = result.data(using: .utf8) else {
                print("Ошибка: JSON не может быть преобразован в Data")
                errorMessage = "Ошибка: данные не могут быть преобразованы"
                isLoading = false
                return
            }
            
            // Декодируем данные в объект ResponseDestination
            let response = try decoder.decode(ResponseDestination.self, from: jsonData)
            
            // Присваиваем полученные данные переменным destinations и cities
            destinations = response
            cities = extractCities(response)
                .filter { !$0.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                .sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
            
            print("✅ getStationList() выполнен успешно")  // Лог успешного выполнения
        } catch {
            print("❌ Ошибка при загрузке станций:", error)
            errorMessage = "Ошибка: \(error.localizedDescription)"
        }
        
        isLoading = false
    }

    
    
    private func extractCities(_ destination: ResponseDestination) -> [Destinations] {
        var cities: [Destinations] = []
        for country in destination.countries {
            for region in country.regions {
                for settlement in region.settlements {
                    cities.append(Destinations(name: settlement.title))
                }
            }
        }
        return cities
    }
    
    func getStations(for settlement: String) {
        guard let destinations = destinations else { return }
        
        var stationsList: [Destinations] = []
        
        for country in destinations.countries {
            for region in country.regions {
                for settlementData in region.settlements {
                    if settlementData.title == settlement {
                        stationsList.append(contentsOf: settlementData.stations.map { Destinations(name: $0.title, stationId: $0.codes.yandex_code) })
                    }
                }
            }
        }
        
        let uniqueStations = Array(Set(stationsList))
        
        DispatchQueue.main.async {
            self.stations = uniqueStations
        }
    }
    
}
