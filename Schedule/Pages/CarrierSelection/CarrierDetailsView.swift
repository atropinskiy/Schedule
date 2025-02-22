//
//  CarrierDetails.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct CarrierDetailsView: View {
    @ObservedObject var viewModel: CarrierViewModel
    @Environment(\.dismiss) private var dismiss
    private var carrier: Int
    
    init(viewModel: CarrierViewModel, carrier: Int) {
        self.viewModel = viewModel
        self.carrier = carrier
    }
    
    var body: some View {
        VStack(spacing: 16) {
            CarrierLogoView(logoUrl: viewModel.carrierDetails?.logoUrl)
            CarrierTitleView(title: viewModel.carrierDetails?.title)
            CarrierContactView(viewModel: viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(16)
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("AT-black-DN"))
                }
            }
        }
        .task {
            await viewModel.getCarrierDetailsById(id: carrier)
        }
    }
}

// MARK: - Логотип перевозчика
struct CarrierLogoView: View {
    let logoUrl: String?
    
    var body: some View {
        if let logoUrl = logoUrl, !logoUrl.isEmpty {
            AsyncImage(url: URL(string: logoUrl)) { phase in
                ZStack {
                    switch ImageLoadState(from: phase) {
                    case .loading:
                        ProgressView()
                            .frame(height: 104)
                    case .success(let image):
                        image.resizable()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 104)
                            .transition(.opacity)
                    case .failure:
                        Image("placeholder")
                            .resizable()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 104)
                    }
                }
            }
        } else {
            Text("Нет логотипа")
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 104)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Enum для состояний загрузки изображения
enum ImageLoadState {
    case loading
    case success(Image)
    case failure
    
    init(from phase: AsyncImagePhase) {
        switch phase {
        case .empty:
            self = .loading
        case .success(let image):
            self = .success(image)
        case .failure:
            self = .failure
        @unknown default:
            self = .failure
        }
    }
}

// MARK: - Название перевозчика
struct CarrierTitleView: View {
    let title: String?
    
    var body: some View {
        Text(title ?? "")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 24, weight: .bold))
    }
}

// MARK: - Контактная информация
struct CarrierContactView: View {
    @ObservedObject var viewModel: CarrierViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            CarrierDetailsRow(field: "E-mail", subtext: (viewModel.carrierDetails?.email?.isEmpty == false) ? viewModel.carrierDetails?.email ?? "Не указано" : "Не указано")
            CarrierDetailsRow(field: "Телефон", subtext: (viewModel.carrierDetails?.phone?.isEmpty == false) ? viewModel.carrierDetails?.phone ?? "Не указано" : "Не указано")
        }
    }
}
