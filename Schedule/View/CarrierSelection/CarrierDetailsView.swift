//
//  CarrierDetails.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct CarrierDetailsView: View {
    private var carrier: String
    init(carrier: String) {
        self.carrier = carrier
    }
    var body: some View {
        VStack (spacing: 16){
            Image("RZD_detail")
            Text("ОАО «РЖД»")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24, weight: .bold))
            VStack (spacing:0) {
                CarrierDetailsRow(field: "E-mail", subtext: "i.lozgkina@yandex.ru")
                CarrierDetailsRow(field: "Телефон", subtext: "+7 (904) 329-27-71")
            }
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 16)
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CarrierDetailsView(carrier: "РЖД")
}
