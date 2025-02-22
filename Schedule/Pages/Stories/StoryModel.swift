//
//  DestinationModel.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import Foundation

struct Story: Identifiable, Hashable, Sendable {
    var id = UUID()
    var name: String
    var imgName: String
    var shown: Bool
    var text1: String
    var text2: String
}



