//
//  ContentView.swift
//
//  Created by alex_tr on 27.12.2024.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var stations: [Components.Schemas.Station] = []
    @State private var copyRight: Components.Schemas.Copyright?
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack(path: $viewModel.path) {
            VStack(spacing: 12) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        ForEach(viewModel.story.indices, id: \.self) { index in
                            let story = viewModel.story[index]
                            ZStack {
                                if story.shown == false {
                                    Image(story.imgName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 92, height: 140)
                                        .clipped()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.blue, lineWidth: 4))
                                        .onTapGesture {
                                            viewModel.setStoryShown(id: index)
                                            viewModel.selectStory(at: index)
                                        }
                                } else {
                                    Image(story.imgName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 92, height: 140)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .opacity(0.5)
                                        .onTapGesture {
                                            viewModel.selectStory(at: index)
                                        }
                                    
                                }
                                VStack {
                                    Spacer()
                                    Text(story.text1)
                                        .foregroundColor(.white)
                                        .lineLimit(3)
                                        .truncationMode(.tail)
                                        .font(.system(size: 12, weight: .regular))
                                        .padding(.horizontal, 0)
                                        .padding(.bottom, 12)
                                    
                                }
                                .frame(width: 76, alignment: .leading)
                                .padding(0)
                            }
                        }
                    }
                }
                .frame(height: 140)
                .fullScreenCover(isPresented: $viewModel.showingStories, onDismiss: {
                    viewModel.closeStory()
                }) {
                    if let selectedStoryIndex = viewModel.selectedStoryIndex {
                        StoryViewFullScreen(viewModel: viewModel, storyIndex: selectedStoryIndex)
                    } else {
                        Text("No story selected")
                    }
                }
                .padding(.top, 24)
                .frame(height: 188)
                
                DestinationsStack(viewModel: viewModel)
                Spacer()
            }
            
        }
        .padding(.horizontal, 16)
    }
}

struct DestinationsStack: View {
    @ObservedObject var viewModel: ScheduleViewModel
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                HStack (spacing: 16) {
                    VStack(spacing: 0) {
                        let city = viewModel.selectedCityFrom?.name
                        let station = viewModel.selectedStationFrom?.name
                        let fromText = (city != nil && station != nil) ? "(\(city ?? "")) \(station ?? "")" : "Откуда"
                        NavigationLink(value: "from") {
                            Text(fromText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 48)
                                .foregroundColor(city != nil && station != nil ? .black : .gray)
                                .font(.system(size: 17, weight: .medium))
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        NavigationLink(value: "to") {
                            let cityTo = viewModel.selectedCityTo?.name
                            let stationTo = viewModel.selectedStationTo?.name
                            let fromTextTo = (cityTo != nil && stationTo != nil) ? "(\(cityTo ?? "")) \(stationTo ?? "")" : "Куда"
                            Text(fromTextTo)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 48)
                                .foregroundColor(cityTo != nil && stationTo != nil ? .black : .gray)
                                .font(.system(size: 17, weight: .medium))
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                    .navigationDestination(for: String.self) { value in
                        if value == "from" {
                            CitySelectionView(viewModel: viewModel, field: "from")
                        } else if value == "to" {
                            CitySelectionView(viewModel: viewModel, field: "to")
                        }
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .frame(height: 98)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    
                    Button(action: {
                        let tempCity = viewModel.selectedCityFrom
                        let tempStation = viewModel.selectedStationFrom
                        viewModel.selectedCityFrom = viewModel.selectedCityTo
                        viewModel.selectedStationFrom = viewModel.selectedStationTo
                        viewModel.selectedCityTo = tempCity
                        viewModel.selectedStationTo = tempStation
                    }) {
                        Image("swapButton")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .cornerRadius(40)
                }
                .background(Color.blue)
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 128)
            .background(Color.blue)
            .cornerRadius(20)
            .padding(.top, 20)
            
            let finalFrom = "\(viewModel.selectedCityFrom?.name ?? "Город отправления") (\(viewModel.selectedStationFrom?.name ?? "Станция отправления"))"
            let finalTo = "\(viewModel.selectedCityTo?.name ?? "Город прибытия") (\(viewModel.selectedStationTo?.name ?? "Станция прибытия"))"
            
            if viewModel.selectedStationTo != nil && viewModel.selectedStationFrom != nil {
                NavigationLink(destination: CarrierView(viewModel: viewModel, destinationFrom: finalFrom, destinationTo: finalTo)) {
                    Text("Найти")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150, height: 60)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


