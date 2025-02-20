//
//  DestinationsModels.swift
//  Schedule
//
//  Created by alex_tr on 20.02.2025.
//

import Foundation

struct Destinations: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var stationId: String?
}
// Модели Списка станций
struct ResponseCountry: Codable {
    let title: String
    let regions: [ResponseRegion]
}

struct ResponseRegion: Codable {
    let title: String
    let settlements: [ResponseSettlement]
}

struct ResponseSettlement: Codable {
    let title: String
    let stations: [ResponseStation]
}

struct ResponseStation: Codable {
    let title: String
    let longitude: Double?
    let latitude: Double?
    let codes: StationCodes

    enum CodingKeys: String, CodingKey {
        case title, longitude, latitude, codes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        codes = try container.decode(StationCodes.self, forKey: .codes)
        
        // Обработка longitude
        if let longitudeString = try? container.decode(String.self, forKey: .longitude),
           let longitudeValue = Double(longitudeString) {
            longitude = longitudeValue
        } else {
            longitude = try? container.decode(Double.self, forKey: .longitude)
        }
        
        // Обработка latitude
        if let latitudeString = try? container.decode(String.self, forKey: .latitude),
           let latitudeValue = Double(latitudeString) {
            latitude = latitudeValue
        } else {
            latitude = try? container.decode(Double.self, forKey: .latitude)
        }
    }
}


struct StationCodes: Codable {
    let yandex_code: String
}

struct ResponseDestination: Codable {
    let countries: [ResponseCountry]
}
