//
//  Models.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import Foundation

struct Destiinations: Identifiable, Hashable {
    var id = UUID()
    var name: String
}

struct Story: Identifiable, Hashable {
    var id = UUID()
    var name: String
}
