//
//  CarrierViewModel.swift
//  Schedule
//
//  Created by alex_tr on 20.02.2025.
//

import SwiftUI

@MainActor
class CarrierViewModel: ObservableObject {
    @Published var carrierList: [CarrierModel] = []
    @Published var isLoading: Bool = false
    @Published var timeSelections: [String]
    @Published var transferFlag: Bool?
    @Published var stationFrom: String?
    @Published var stationTo: String?
    @Published var carrierDetails: CarrierDetailsModel?
    private var offset = 0
    private let limit = 30
    private var networkService = NetworkService()
    private var isLastPage = false
    
    init () {
        self.timeSelections = []
    }
    
    func getCarriers(stationFrom: Destinations, stationTo: Destinations) async {
            guard !isLoading, !isLastPage else { return }
            isLoading = true

            guard let fromId = stationFrom.stationId, let toId = stationTo.stationId else {
                isLoading = false
                return
            }

            do {
                let result = try await networkService.ticketsSearch(from: fromId, to: toId, limit: limit, offset: offset, has_transfers: "true")
                guard let segments = result.segments, !segments.isEmpty else {
                    print("Ошибка: Сегменты не найдены")
                    isLastPage = true  // Данные закончились
                    isLoading = false
                    return
                }

                var newCarriers: [CarrierModel] = []
                for segment in segments {
                    if let thread = segment.thread, let carrier = thread.carrier {
                        let carrierName = carrier.title ?? "Не указано"
                        let carrierCode = carrier.code ?? 0
                        let carrierLogo = carrier.logo ?? "Нет логотипа"
                        let departureTime = segment.departure ?? "Не указано"
                        let arrivalTime = segment.arrival ?? "Не указано"
                        let duration = segment.duration ?? 0.0
                        let startDate = segment.start_date ?? "Не указано"
                        let has_transfers = segment.has_transfers
                        
                        newCarriers.append(CarrierModel(name: carrierName, timeStart: arrivalTime, timeFinish: departureTime, duration: duration, iconName: carrierLogo, date: startDate, carrierCode: carrierCode, hasTransfers: has_transfers))
                    }
                }

                carrierList.append(contentsOf: newCarriers)
                offset += limit  // Увеличиваем отступ для следующей загрузки
                isLoading = false
            } catch {
                print("Ошибка загрузки перевозчиков: \(error)")
                isLoading = false
            }
        }
    
    func getCarrierDetailsById(id: Int) async {
        do {
            let result = try await networkService.getCarriers(code: String(id))
            print(result)
            let carrier = CarrierDetailsModel(
                title: result.title,
                logoUrl: result.logoUrl,
                email: result.email,
                phone: result.phone
            )
            
            self.carrierDetails = carrier // Обновление @Published свойства без DispatchQueue
        } catch {
            print("Ошибка загрузки перевозчиков: \(error)")
            self.carrierDetails = nil // Обнуляем в случае ошибки
        }
    }

    
    func carrierInInterval(carrier: CarrierModel) -> String {
        guard let hour = Int(carrier.timeStart.prefix(2)) else {
            return "Неверное время"
        }
        
        switch hour {
        case 6..<12:
            return "Утро 06:00-12:00"
        case 12..<18:
            return "День 12:00-18:00"
        case 18..<24:
            return "Вечер 18:00-00:00"
        case 0..<6:
            return "Ночь 00:00-06:00"
        default:
            return "Вне диапазона"
        }
    }
    
}

