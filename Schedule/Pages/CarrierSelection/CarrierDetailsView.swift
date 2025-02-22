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
    
    init(viewModel:CarrierViewModel ,carrier: Int) {
        self.viewModel = viewModel
        self.carrier = carrier
    }
    
    var body: some View {
        
        VStack (spacing: 16){
            if let logoUrl = viewModel.carrierDetails?.logoUrl, !logoUrl.isEmpty {
                AsyncImage(url: URL(string: logoUrl)) { phase in
                    ZStack {
                        if case .empty = phase {
                            ProgressView()
                                .frame(height: 104)
                        }
                        if case .success(let image) = phase {
                            image.resizable()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 104)
                                .transition(.opacity)
                        }
                        if case .failure = phase {
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
            Text(viewModel.carrierDetails?.title ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24, weight: .bold))
            VStack (spacing:0) {
                CarrierDetailsRow(
                    field: "E-mail",
                    subtext: (viewModel.carrierDetails?.email?.isEmpty == false) ? viewModel.carrierDetails?.email ?? "Не указано" : "Не указано"
                )
                CarrierDetailsRow(
                    field: "Телефон",
                    subtext: (viewModel.carrierDetails?.phone?.isEmpty == false) ? viewModel.carrierDetails?.phone ?? "Не указано" : "Не указано"
                )
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(16)
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("AT-black-DN"))
                        .padding(.horizontal, 0)
                }
            }
        }
        .task {
            await viewModel.getCarrierDetailsById(id: carrier)
        }
    }
}
