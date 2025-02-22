//
//  ErrorModels.swift
//  Schedule
//
//  Created by alex_tr on 29.01.2025.
//

import Foundation

struct ErrorModel {
    var label: String
    var imgName: String
}

enum ErrorType {
    case server_error
    case internet_error
    
    var errorModel: ErrorModel {
        switch self {
        case .server_error:
            return ErrorModel(label: "Ошибка сервера", imgName: "error1")
        case .internet_error:
            return ErrorModel(label: "Нет интернета", imgName: "error2")
        }
    }
}

