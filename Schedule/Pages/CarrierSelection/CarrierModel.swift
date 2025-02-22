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
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Исходный формат даты
        dateFormatter.locale = Locale(identifier: "ru_RU") // Русская локаль
        
        if let dateObject = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "d MMMM" // Желаемый формат (например, "14 января")
            return dateFormatter.string(from: dateObject)
        }
        
        return date
    }
    
    func trimmedTimeStart() -> String {
        return String(timeStart.dropLast(3))
    }
    
    func trimmedTimeFinish() -> String {
        return String(timeFinish.dropLast(3))
    }
}



