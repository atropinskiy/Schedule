//
//  ViewController.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    let items = Array(1...20).map { "Story \($0)" }
    @State private var stations: [Components.Schemas.Station] = []
    @State private var trips: Components.Schemas.Trips?
    
    @State private var errorMessage: String? = nil
    @State private var text1: String = ""
    @State private var text2: String = ""
    
    let client = Client(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport())
    let service: NetworkServiceProtocol
    
    
    init() {
        // Инициализация сервиса
        self.service = NetworkService(client: client, apikey: Constants.token)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        StoryCell(item: item)
                    }
                }
                
            }
            .frame(height: 188)
            .padding(.vertical, 24) // Отступ сверху
            
            ZStack {
                HStack(spacing: 16) { // Убираем отступы между элементами
                    VStack(spacing: 0) {
                        TextField("Откуда", text: $text1)
                            .frame(height: 48)
                            .padding(.horizontal, 16)
                        
                        TextField("Куда", text: $text2)
                            .frame(height: 48)
                            .padding(.horizontal, 16)
                        
                    }
                    .frame(height: 96) // Сохраняем высоту для List
                    .padding(.vertical, 0)
                    .background(Color(.white))
                    .cornerRadius(20)
                    
                    
                    Button(action: {
                        print("Кнопка нажата!")
                    }) {
                        Image("swapButton")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 36, height: 36)
                    .background()
                    .cornerRadius(40)
                    
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .background(Color.blue)
            .cornerRadius(20)
            HStack {
                Button(action: {
                    Task {
                        await fetchNearestStations()
                    }
                }) {
                    Text("Ближайшие станции")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.blue) // Цвет фона кнопки
                .cornerRadius(10) // Закругление углов кнопки
                Button(action: {
                    Task {
                        await searchTrips() 
                    }
                }) {
                    Text("Поиск рейсов")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.blue) // Цвет фона кнопки
                .cornerRadius(10) // Закругление углов кнопки
            }            
            HStack {
                Button(action: {
                    Task {
                        await fetchNearestStations()
                    }
                }) {
                    Text("Ближайшие станции")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.blue) // Цвет фона кнопки
                .cornerRadius(10) // Закругление углов кнопки
                Button(action: {
                    Task {
                        await searchTrips() 
                    }
                }) {
                    Text("Поиск рейсов")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.blue) // Цвет фона кнопки
                .cornerRadius(10) // Закругление углов кнопки
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemBackground))
        .padding(.horizontal, 16)
    }
    
    func fetchNearestStations() async {
        let lat: Double = 59.864177
        let lng: Double = 30.319163
        let distance: Int = 50
        errorMessage = nil
        do {
            let result = try await service.getNearestStations(lat: lat, lng: lng, distance: distance)
            DispatchQueue.main.async {
                self.stations = result.stations ?? []
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Ошибка: \(error.localizedDescription)"
            }
        }
    }
    
    func searchTrips() async {
        let from: String = "c213"
        let to: String = "c146"
        errorMessage = nil
        Task {
            trips = try await service.searchTrips(from: from, to: to)
            print(trips ?? "Пусто")
        }
    }
    
    func testCopyRight() async {
        let from: String = "c213"
        let to: String = "c146"
        errorMessage = nil
        Task {
            trips = try await service.searchTrips(from: from, to: to)
            print(trips ?? "Пусто")
        }
    }
    
    func testCopyright() async {
        let format = "json"
        Task {
            trips = try await service.searchTrips(from: from, to: to)
            print(trips ?? "Пусто")
        }
    }

    
}



