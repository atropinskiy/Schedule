//
//  CarrierCard.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct CarrierCard: View {
    private var cardCarrier: CarrierModel
    
    init (cardCarrier: CarrierModel) {
        self.cardCarrier = cardCarrier
    }
    var body: some View {
            VStack (spacing: 4) {
                ZStack {
                    HStack (spacing: 8) {
                        if !cardCarrier.iconName.isEmpty, let url = URL(string: cardCarrier.iconName) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView() // Индикатор загрузки
                                        .frame(width: 40, height: 40)
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40) // Размер изображения
                                case .failure:
                                    EmptyView()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            EmptyView()
                        }

                        
                        VStack {
                            Text(cardCarrier.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.black)
                            if let hasTransfers = cardCarrier.hasTransfers, !hasTransfers.isEmpty {
                                Text(hasTransfers)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.red)
                                    .font(.system(size: 12, weight: .regular))
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        VStack{
                            Text(cardCarrier.formattedDate())
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 7)
                        .padding(.bottom, 15)
                        .frame(maxWidth: 100, alignment: .topTrailing)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Text(cardCarrier.timeStart.dropLast(3))
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                    Image("Separator")
                    Text("\(Int(cardCarrier.duration/60/60)) Часов")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black)
                    Image("Separator")
                    Text(cardCarrier.timeFinish.dropLast(3))
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                }
                .frame(height: 48)
            }
            .padding(.horizontal, 14)
            .padding(.top, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 104)
            .background(Color("AT-lightGray"))
            .cornerRadius(24)
            .zIndex(2)
            .contentShape(Rectangle())
    }
    
    
}

#Preview {
    CarrierCard(cardCarrier: CarrierModel(name: "РЖД", transfer: "С пересадкой в Костроме", timeStart: "22:30", timeFinish: "08:15", duration: 15.02, iconName: "RZD", date: "14 января", carrierCode: 146))
}
