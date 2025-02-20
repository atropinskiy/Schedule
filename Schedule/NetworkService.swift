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

struct CountriesList: Codable {
    let countries: [String]
}



protocol NetworkServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func getCopyright(format: Format) async throws -> Copyright
    func testCarriers(code: String) async throws -> Carrier
    func getNearestSettlement(lat: Double, lng: Double) async throws -> Settlement
    func getThread(uid: String) async throws -> Thread
    func ticketsSearch(from: String, to: String) async throws -> TicketResult
    func getStationsList() async throws -> String
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


actor NetworkService: NetworkServiceProtocol {
    private let client: Client
    private let apikey: String
    let configuration = URLSessionConfiguration.default
    
    
    init() {
        do {
            let url = try Servers.Server1.url()
            self.client = Client(serverURL: url, transport: URLSessionTransport())
            self.apikey = Constants.token
        } catch {
            fatalError("Ошибка при получении URL сервера: \(error.localizedDescription)")
        }
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
    
    func getCopyright(format: Format) async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey,
            format: format.rawValue
        ))
        
        print("Ответ сервера:", try response.ok.body)
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
    
    enum FormatPayload: String {
        case json = "json"
        case xml = "xml"
    }
    

    func getStationsList() async throws -> String {
        print("Начинаем тестирование")

        do {
            let response = try await client.getStationsList(query: .init(apikey: apikey, format: "json"))
            let body = try response.ok.body

            if case .html(let bodyStream) = body {
                // Собираем весь поток данных в единый объект Data
                let fullData = try await bodyStream.reduce(into: Data()) { $0.append(contentsOf: $1) }

                // Преобразуем Data в строку UTF-8
                if let resultString = String(data: fullData, encoding: .utf8) {
                    return resultString
                } else {
                    throw NSError(domain: "Invalid response", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Не удалось преобразовать результат в строку UTF-8"])
                }
            } else {
                throw NSError(domain: "Invalid response", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Ответ не содержит данные в формате HTML"])
            }
        } catch {
            throw error
        }
    }

    func getSchedules(station: String) async throws -> Schedules {
        print("Начинаем тестирование")
        do {
            // Отправка запроса на сервер
            let response = try await client.getSchedule(query: .init(
                apikey: apikey,
                station: station,
                date: "2025-01-02"
            ))
            
            print("Ответ сервера: \(response)")
            
            return try response.ok.body.json
        } catch {
            print("Произошла ошибка: \(error)")
            throw error
        }
    }
    
    
}

