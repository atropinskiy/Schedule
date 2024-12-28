//
//  NearestStationsService.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession


protocol NetworkServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func searchTrips(from: String, to: String) async throws -> Trips
    func getCopyright(format: String) async throws -> Copyright
}

typealias NearestStations = Components.Schemas.Stations
typealias Trips = Components.Schemas.Trips
typealias Copyright = Components.Schemas.Copyright

final class NetworkService: NetworkServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        print(response)
        return try response.ok.body.json
    }    
    
    func searchTrips(from: String, to: String) async throws -> Trips {
        let response = try await client.searchTrips(query: .init(
            from: from,
            to: to,
            apikey: apikey
        ))
        print("Ответ сервера", response)
        return try response.ok.body.json
    }    
    
    func getCopyright(format: String) async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey,
            format: format
        ))
        print("Ответ сервера", response)
        return try response.ok.body.json
    }

}

