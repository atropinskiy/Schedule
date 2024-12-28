//
//  NearestStationsService.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//
import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

enum Format: String {
    case json
    case xml
}


protocol NetworkServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func getCopyright(format: Format) async throws -> Copyright
    func testCarriers(code: String) async throws -> Carrier
    func getNearestSettlement(lat: Double, lng: Double) async throws -> Settlement
    func getThread(uid: String) async throws -> Thread
    func ticketsSearch(from: String, to: String) async throws -> TicketResult
    func getStationList() async throws -> StationList
    func getSchedules(station: String) async throws -> Schedules
}

typealias NearestStations = Components.Schemas.Stations
typealias Copyright = Components.Schemas.Copyright
typealias Carrier = Components.Schemas.Carrier
typealias Settlement = Components.Schemas.Settlement
typealias Thread = Components.Schemas.Thread
typealias TicketResult = Components.Schemas.TicketResult
typealias StationList = Components.Schemas.CountriesList
typealias Schedules = Components.Schemas.Schedules


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
        print("Ответ сервера:", response)
        return try response.ok.body.json
    }    
    
    func getCopyright(format: Format) async throws -> Copyright {
         let response = try await client.getCopyright(query: .init(
             apikey: apikey,
             format: format.rawValue // передаем формат как строку
         ))
         
         // Печать ответа для отладки
         print("Ответ сервера:", try response.ok.body)

         // Декодируем тело ответа в структуру CopyrightResponse
         return try response.ok.body.json
     }
    
    func testCarriers(code: String) async throws -> Carrier {
        let response = try await client.getCarrier(query: .init(
            apikey: apikey,
            code: code
        ))
        print("Ответ сервера", response)
        return try response.ok.body.json
    }        
    
    func getNearestSettlement(lat: Double, lng: Double) async throws -> Settlement {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng
        ))
        print("Ответ сервера", response)
        return try response.ok.body.json
    }    
    
    func getThread(uid: String) async throws -> Thread {
        print("Начинаем тестирование")
        do {
            let response = try await client.getThread(query: .init(
                uid: uid,
                apikey: apikey
            ))
            print("Ответ сервера", response)
            return try response.ok.body.json
        } catch {
            print("Произошла ошибка: \(error)")
            throw error
        }
    }    
    
    func ticketsSearch(from: String, to: String) async throws -> TicketResult {
        print("Начинаем тестирование")
        do {
            let response = try await client.getTickets(query: .init(
                from: from,
                to: to,
                apikey: apikey,
                limit: 1
            ))
            print("Ответ сервера", response)
            return try response.ok.body.json
        } catch {
            print("Произошла ошибка: \(error)")
            throw error
        }
    }
    
    func getStationList() async throws -> StationList {       
        print("Начинаем тестирование")
        do {
            let response = try await client.getStationsList(query: .init(
                apikey: apikey,
                format: "json"
            ))
            print("Ответ сервера", response)
            return try response.ok.body.json
        } catch {
            print("Произошла ошибка: \(error)")
            throw error
        }
    }    
    
    func getSchedules(station: String) async throws -> Schedules {
        print("Начинаем тестирование")
        do {
            let response = try await client.getSchedule(query: .init(
                apikey: apikey,
                station: station,
                date: "2025-01-02"
            ))
            print("Ответ сервера", response)
            return try response.ok.body.json
        } catch {
            print("Произошла ошибка: \(error)")
            throw error
        }
    }
    

}

