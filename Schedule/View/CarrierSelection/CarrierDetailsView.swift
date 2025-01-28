//
//  CarrierDetails.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct CarrierDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    private var carrier: String
    init(carrier: String) {
        self.carrier = carrier
    }
    var body: some View {
        VStack (spacing: 16){
            Image("RZD_detail")
                .resizable()
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 104)
            Text("ОАО «РЖД»")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24, weight: .bold))
            VStack (spacing:0) {
                CarrierDetailsRow(field: "E-mail", subtext: "i.lozgkina@yandex.ru")
                CarrierDetailsRow(field: "Телефон", subtext: "+7 (904) 329-27-71")
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
        

    }
    
}

#Preview {
    CarrierDetailsView(carrier: "РЖД")
}
