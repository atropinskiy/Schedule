//
//  CarrierModel.swift
//  Schedule
//
//  Created by alex_tr on 21.02.2025.
//

import Foundation

struct CarrierResponse: Decodable {
    let carrier: CarrierDetailsModel
}

struct CarrierDetailsModel: Decodable {
    var title: String
    var logoUrl: String
    var email: String?
    var phone: String?
}

struct CarrierModel: Identifiable, Hashable, Sendable {
    var id = UUID()
    var name: String
    var transfer: String?
    var timeStart: String
    var timeFinish: String
    var duration: Double
    var iconName: String
    var date: String
    var carrierCode: Int
    var hasTransfers: String?
}



