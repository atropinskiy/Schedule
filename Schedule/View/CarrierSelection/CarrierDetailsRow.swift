//
//  CarrierDetailsCard.swift
//  Schedule
//
//  Created by alex_tr on 26.01.2025.
//

import SwiftUI

struct CarrierDetailsRow: View {
    private var field: String
    private var subtext: String
    
    init(field: String, subtext: String) {
        self.field = field
        self.subtext = subtext
    }
    var body: some View {
        VStack{
            Text(field)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .regular))
            Text(subtext)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Color("AT-blue"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 60)
    }
}

#Preview {
    CarrierDetailsRow(field: "E-mail", subtext: "i.lozgkina@yandex.ru")
}
