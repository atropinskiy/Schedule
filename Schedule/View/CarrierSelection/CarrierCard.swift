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
                        Image(cardCarrier.iconName)
                        VStack {
                            Text(cardCarrier.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 17, weight: .regular))
                            if cardCarrier.transfer != "" {
                                Text(cardCarrier.transfer ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.red)
                                    .font(.system(size: 12, weight: .regular))
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        VStack{
                            Text(cardCarrier.date)
                                .font(.system(size: 12, weight: .regular))
                        }
                        .padding(.trailing, 7)
                        .padding(.bottom, 15)
                        .frame(maxWidth: 100, alignment: .topTrailing)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Text(cardCarrier.timeStart)
                        .font(.system(size: 17, weight: .regular))
                    Image("Separator")
                    Text("20 Часов")
                        .font(.system(size: 12, weight: .regular))
                    Image("Separator")
                    Text(cardCarrier.timeFinish)
                        .font(.system(size: 17, weight: .regular))
                }
                .frame(height: 48)
            }
            .padding(.horizontal, 14)
            .padding(.top, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 104)
            .background(Color("AT-lightGray"))
            .cornerRadius(24)

        }
        
}

#Preview {
    CarrierCard(cardCarrier: CarrierModel(name: "RZD", transfer: "С пересадкой в Костроме", timeStart: "22:30", timeFinish: "08:15", iconName: "RZD", date: "14 января"))
}
