import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

enum Format: String {
    case json, xml
}

protocol NetworkServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func getCopyright(format: Format) async throws -> Copyright
    func getCarriers(code: String) async throws -> CarrierDetailsModel
    func getNearestSettlement(lat: Double, lng: Double) async throws -> Settlement
    func getThread(uid: String) async throws -> Thread
    func ticketsSearch(from: String, to: String, limit: Int?, offset: Int?, has_transfers: String?) async throws -> TicketResult
    func getStationsList() async throws -> String
    func getSchedules(station: String) async throws -> Schedules
}

typealias NearestStations = Components.Schemas.Stations
typealias Copyright = Components.Schemas.Copyright
typealias Carrier = Components.Schemas.CarrierDetails
typealias Settlement = Components.Schemas.Settlement
typealias Thread = Components.Schemas.Thread
typealias TicketResult = Components.Schemas.TicketResult
typealias Schedules = Components.Schemas.Schedules

actor NetworkService: NetworkServiceProtocol {
    private let client: Client
    private let apikey: String

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
        let response = try await client.getNearestStations(query: .init(apikey: apikey, lat: lat, lng: lng, distance: distance))
        print("Ответ сервера: \(response)")
        return try response.ok.body.json
    }

    func getCopyright(format: Format) async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(apikey: apikey, format: format.rawValue))
        print("Ответ сервера: \(response)")
        return try response.ok.body.json
    }

    func getCarriers(code: String) async throws -> CarrierDetailsModel {
        let response = try await client.getCarrier(query: .init(apikey: apikey, code: code))
        print("Ответ сервера: \(response)")

        let carrierResponse = try response.ok.body.json as Components.Schemas.CarrierDetails

        // Безопасно разворачиваем `carrier`
        guard let carrier = carrierResponse.carrier else {
            throw NSError(domain: "APIError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Перевозчик отсутствует в ответе"])
        }

        return CarrierDetailsModel(
            title: carrier.title ?? "",
            logoUrl: carrier.logo ?? "",
            email: carrier.email,
            phone: carrier.phone
        )
    }

    func getNearestSettlement(lat: Double, lng: Double) async throws -> Settlement {
        let response = try await client.getNearestSettlement(query: .init(apikey: apikey, lat: lat, lng: lng))
        print("Ответ сервера: \(response)")
        return try response.ok.body.json
    }

    func getThread(uid: String) async throws -> Thread {
        let response = try await client.getThread(query: .init(uid: uid, apikey: apikey))
        print("Ответ сервера: \(response)")
        return try response.ok.body.json
    }

    func ticketsSearch(from: String, to: String, limit: Int?, offset: Int?, has_transfers: String?) async throws -> TicketResult {
        let response = try await client.getTickets(query: .init(from: from, to: to, apikey: apikey, limit: limit, has_transfers: has_transfers))
        switch response {
        case .ok(let successResponse):
            print("✅ Успешный ответ: \(successResponse)")
            do {
                let ticketResult = try successResponse.body.json as TicketResult
                return ticketResult
            } catch {
                throw NSError(domain: "TicketsAPI", code: 500, userInfo: [NSLocalizedDescriptionKey: "Не удалось распарсить ответ."])
            }

        case .notFound:
            throw NSError(domain: "TicketsAPI", code: 404, userInfo: [NSLocalizedDescriptionKey: "Билеты не найдены"])

        case .badRequest:
            throw NSError(domain: "TicketsAPI", code: 400, userInfo: [NSLocalizedDescriptionKey: "Некорректный запрос"])

        default:
            print("⚠️ Неизвестный ответ: \(response)")
            throw NSError(domain: "TicketsAPI", code: 500, userInfo: [NSLocalizedDescriptionKey: "Неизвестная ошибка"])
        }
    }




    func getSchedules(station: String) async throws -> Schedules {
        let response = try await client.getSchedule(query: .init(apikey: apikey, station: station, date: "2025-01-02"))
        print("Ответ сервера: \(response)")
        return try response.ok.body.json
    }

    func getStationsList() async throws -> String {
        let response = try await client.getStationsList(query: .init(apikey: apikey, format: "json"))
        
        if case .html(let bodyStream) = try response.ok.body {
            var fullData = Data()
            for try await chunk in bodyStream {
                fullData.append(contentsOf: chunk)
            }
            if let resultString = String(data: fullData, encoding: .utf8) {
                return resultString
            } else {
                throw NSError(domain: "Invalid response", code: 1004, userInfo: nil)
            }
        }
        throw NSError(domain: "Invalid response", code: 1003, userInfo: nil)
    }
}
