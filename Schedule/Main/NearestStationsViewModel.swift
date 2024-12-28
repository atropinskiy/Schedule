//
//  ViewModel.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

import Foundation

class NearestStationsViewModel: ObservableObject {
    @Published var stations: [Components.Schemas.Station] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let service: NearestStationsServiceProtocol
    
    // Добавляем инициализатор с параметрами
    init(service: NearestStationsServiceProtocol) {
        self.service = service
    }
    
    // Метод для получения ближайших станций
    func fetchNearestStations(lat: Double, lng: Double, distance: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await service.getNearestStations(lat: lat, lng: lng, distance: distance)
            DispatchQueue.main.async {
                self.stations = result.stations ?? []
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Ошибка: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}



