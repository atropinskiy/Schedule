//
//  ScheduleViewModel.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI

@MainActor
class ScheduleViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var story: [Story]
    @Published var selectedStationFrom: Destinations?
    @Published var selectedStationTo: Destinations?
    @Published var selectedCityFrom: Destinations?
    @Published var selectedCityTo: Destinations?
    @Published var carrierList: [CarrierModel]
    @Published var timeSelections: [String]
    @Published var transferFlag: Bool?
    @Published var showError: ErrorType? = nil
    @Published var showingStories: Bool = false
    @Published var selectedStoryIndex: Int?
    
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
    
    func selectStory(at index: Int) {
        selectedStoryIndex = index
        showingStories = true
    }
    
    func closeStory() {
        showingStories = false
        selectedStoryIndex = nil
    }
    
    func setStoryShown(id: Int) {
        story[id].shown = true
    }
    
    private func updateUserInterfaceStyle() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
    
    init() {
        
        let story1 = Story(
            name: "Story1",
            imgName: "story1_FS",
            shown: false,
            text1: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )        
        let story2 = Story(
            name: "Story2",
            imgName: "story2_FS",
            shown: false,
            text1: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )        
        let story3 = Story(
            name: "Story3",
            imgName: "story3_FS",
            shown: false,
            text1: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )        
        let story4 = Story(
            name: "Story3",
            imgName: "story1_FS",
            shown: false,
            text1: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )        
        let story5 = Story(
            name: "Story3",
            imgName: "story2_FS",
            shown: false,
            text1: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )
        
        let carrier1 = CarrierModel(name: "РЖД",transfer: "С пересадкой в Костроме", timeStart: "22:30", timeFinish: "08:15", iconName: "RZD", date: "14 января")
        let carrier2 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier3 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier4 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier5 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier6 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier7 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        let carrier8 = CarrierModel(name: "ФГК",transfer: "", timeStart: "01:15", timeFinish: "09:00", iconName: "FGK", date: "15 января")
        
        self.timeSelections = []
        self.story = [story1, story2, story3, story4, story5]
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
