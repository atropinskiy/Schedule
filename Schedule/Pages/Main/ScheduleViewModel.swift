//
//  ScheduleViewModel.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI

@MainActor
final class ScheduleViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var selectedStationFrom: Destinations?
    @Published var selectedStationTo: Destinations?
    @Published var selectedCityFrom: Destinations?
    @Published var selectedCityTo: Destinations?
    @Published var showError: ErrorType? = nil
    
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
}
