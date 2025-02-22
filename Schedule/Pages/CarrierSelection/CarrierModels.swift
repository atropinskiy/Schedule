//
//  CarrierModels.swift
//  Schedule
//
//  Created by alex_tr on 21.02.2025.
//

import Foundation

struct TicketResult: Codable {
    struct Station: Codable {
        var code: String
        var title: String
        var transportType: String
        var stationType: String
        var stationTypeName: String
    }
    
    struct Carrier: Codable {
        var title: String
        var url: String
    }

    struct TicketInfo: Codable {
        var carrier: Carrier
        var departure: String
        var arrival: String
        var hasTransfers: Bool
        var duration: Int
        var startDate: String
        var threadMethodLink: String
    }
    
    var intervalSegments: [IntervalSegment]
}

struct IntervalSegment: Codable {
    var from: Station
    var to: Station
    var thread: Thread
    var departure: String
    var arrival: String
    var duration: Int
    var hasTransfers: Bool
    var ticketsInfo: TicketsInfo
}

struct Thread: Codable {
    var carrier: Carrier
    var title: String
    var number: String
    var vehicle: String
    var threadMethodLink: String
}

struct TicketsInfo: Codable {
    var places: [TicketPlace]
}

struct TicketPlace: Codable {
    var currency: String
    var price: TicketPrice
    var name: String
}

struct TicketPrice: Codable {
    var whole: Int
    var cents: Int
}

