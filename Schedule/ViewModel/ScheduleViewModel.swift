//
//  ScheduleViewModel.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI

class ScheduleViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var story: [Story]
    @Published var towns: [Destinations]
    @Published var stations: [Destinations]
    @Published var selectedStationFrom: Destinations?
    @Published var selectedStationTo: Destinations?
    @Published var selectedCityFrom: Destinations?
    @Published var selectedCityTo: Destinations?
    @Published var carrierList: [CarrierModel]
    @Published var timeSelections: [String]
    @Published var transferFlag: Bool?
    @Published var isDarkMode: Bool = false {
        didSet {
            updateUserInterfaceStyle()
        }
    }
    
    enum Path: Hashable {
        case citySelectionView(field: String)
        case stationSelectionView
    }
    
    func navigate(to destination: Path) {
        path.append(destination)
    }
    
    func removeAll() {
        path = NavigationPath()
    }
    
    func goBack() {
        path.removeLast()
    }
    
    private func updateUserInterfaceStyle() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
    
    init() {
        
        let story1 = Story(name: "Story1", imgName: "story1_FS")
        let story2 = Story(name: "Story2", imgName: "story2_FS")
        let story3 = Story(name: "Story3", imgName: "story3_FS")
        
        let town1 = Destinations(name: "Москва")
        let town2 = Destinations(name: "Санкт-Петербург")
        let town3 = Destinations(name: "Сочи")
        let town4 = Destinations(name: "Горный воздух")
        
        let station1 = Destinations(name: "Станция 1")
        let station2 = Destinations(name: "Станция 2")
        let station3 = Destinations(name: "Станция 3")
        let station4 = Destinations(name: "Станция 4")
        
        let carrier1 = CarrierModel(name: "РЖД",transfer: "С пересадкой в Костроме", timeStart: "22:30", timeFinish: "08:15", iconName: "RZD", date: "14 января")
        let carrier2 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier3 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier4 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier5 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier6 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier7 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier8 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        
        self.timeSelections = []
        self.story = [story1, story2, story3]
        self.towns = [town1, town2, town3, town4]
        self.stations = [station1, station2, station3, station4]
        self.carrierList = [carrier1, carrier2, carrier3, carrier4, carrier5, carrier6, carrier7, carrier8]
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
