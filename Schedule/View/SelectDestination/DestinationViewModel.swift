//
//  CitySelectionViewModel.swift
//  Schedule
//
//  Created by alex_tr on 20.02.2025.
//

import SwiftUI
import Combine


class DestinationViewModel: ObservableObject {
    @Published var destinations: ResponseDestination?
    @Published var errorMessage: String?
    @Published var cities: [Destinations]?
    @Published var stations: [Destinations] = []
    private var networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
   
    func getStationList() async {
        print("Тестируем station list")
        let decoder = JSONDecoder()
        
        do {
            let result = try await networkService.getStationsList()
            guard let jsonData = result.data(using: .utf8) else {
                print("Ошибка: JSON не может быть преобразован в Data")
                DispatchQueue.main.async {
                    self.errorMessage = "Ошибка: данные не могут быть преобразованы"
                }
                return
            }
            
            let response = try decoder.decode(ResponseDestination.self, from: jsonData)
            print("Успешно декодировано:")

            DispatchQueue.main.async {
                self.destinations = response
                self.cities = self.extractCities(response)
                    .filter { !$0.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                    .sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
            }
        } catch let decodingError {
            print("Ошибка:", decodingError)
            DispatchQueue.main.async {
                self.errorMessage = "Ошибка: \(decodingError.localizedDescription)"
            }
        }
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
                        stationsList.append(contentsOf: settlementData.stations.map { Destinations(name: $0.title) })
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
