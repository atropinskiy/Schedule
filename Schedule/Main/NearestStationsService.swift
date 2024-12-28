//
//  NearestStationsService.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

// 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession


// 2. Улучшаем читаемость кода — необязательный шаг
typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol {
  func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService: NearestStationsServiceProtocol {
  private let client: Client
    private let apikey: Constants
  
  init(client: Client, apikey: String) {
    self.client = client
      self.apikey = Constants.token
  }
  
  func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
  // В документе с описанием запроса мы задали параметры apikey, lat, lng и distance
  // Для вызова сгенерированной функции нужно передать эти параметры
    let response = try await client.getNearestStations(query: .init(
        apikey: apikey,
        lat: lat,
        lng: lng,
        distance: distance
    ))
    return try response.ok.body.json
  }
}
