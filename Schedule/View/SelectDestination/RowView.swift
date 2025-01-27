//
//  RowView.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI

struct RowView: View {
    var destination: Destinations
    var body: some View {
        HStack () {
            Text(destination.name)
                .font(.system(size: 17, weight: .regular))
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.black) 
            Spacer()
            Image("navArrow")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .frame(height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    RowView(destination: Destinations.init(name: "Москва"))
}
