//
//  DestinationModel.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import Foundation

struct Destinations: Identifiable, Hashable {
    var id = UUID()
    var name: String
}

struct Story: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var imgName: String
}

struct CarrierModel: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var transfer: String?
    var timeStart: String
    var timeFinish: String
    var iconName: String
    var date: String
}

