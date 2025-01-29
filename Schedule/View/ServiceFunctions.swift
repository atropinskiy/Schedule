//
//  ServiceFunctions.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

//import SwiftUI
//private func fetchNearestStations() async {
//    let lat: Double = 59.864177
//    let lng: Double = 30.319163
//    let distance: Int = 50
//    errorMessage = nil
//    do {
//        let result = try await service.getNearestStations(lat: lat, lng: lng, distance: distance)
//        DispatchQueue.main.async {
//            self.stations = result.stations ?? []
//        }
//    } catch {
//        DispatchQueue.main.async {
//            self.errorMessage = "Ошибка: \(error.localizedDescription)"
//        }
//    }
//}
//
//private func testCopyright() async {
//    do {
//        let result = try await service.getCopyright(format: .json)
//        DispatchQueue.main.async {
//            self.copyRight = result
//        }
//    } catch {
//        DispatchQueue.main.async {
//            self.errorMessage = "Ошибка: \(error.localizedDescription)"
//        }
//    }
//}
//private func testCarriers() async {
//    do {
//        let _ = try await service.testCarriers(code: "680")
//        DispatchQueue.main.async {
//        }
//    } catch {
//        DispatchQueue.main.async {
//            self.errorMessage = "Ошибка: \(error.localizedDescription)"
//        }
//    }
//}
//private func testSatlements() async {
//    do {
//        let _ = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163)
//        DispatchQueue.main.async {
//        }
//    } catch {
//        DispatchQueue.main.async {
//            self.errorMessage = "Ошибка: \(error.localizedDescription)"
//        }
//    }
//}
//
//private func getThread() async {
//    print("Тестируем тред")
//    do {
//        let _ = try await service.getThread(uid: "098S_0_2")
//        DispatchQueue.main.async {
//        }
//    } catch {
//        DispatchQueue.main.async {
//            self.errorMessage = "Ошибка: \(error.localizedDescription)"
//        }
//    }
//}
//
//private func getTickets() async {
//    print("Тестируем тред")
//    do {
//        let _ = try await service.ticketsSearch(
//            from: "c146",
//            to: "c213"
//        )
//        DispatchQueue.main.async {
//        }
//    } catch {
//        DispatchQueue.main.async {
//            self.errorMessage = "Ошибка: \(error.localizedDescription)"
//        }
//    }
//}
//
//private func getStationList() async {
//    print("Тестируем station list")
//    do {
//        let _ = try await service.getStationsList()
//        DispatchQueue.main.async {
//        }
//    } catch {
//        DispatchQueue.main.async {
//            self.errorMessage = "Ошибка: \(error.localizedDescription)"
//        }
//    }
//}
//
//private func getSchedule() async {
//    print("Тестируем schedule")
//    do {
//        let _ = try await service.getSchedules(station: "s9600213")
//        DispatchQueue.main.async {
//        }
//    } catch {
//        DispatchQueue.main.async {
//            self.errorMessage = "Ошибка: \(error.localizedDescription)"
//        }
//    }
//}
