//
//  FilterHeader.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct FilterHeader: View {
    private var title: String
    init(title:String) {
        self.title = title
    }
    var body: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .background(.clear)
            .foregroundColor(Color("AT-black-DN"))
            .padding(0)
    }
}

#Preview {
    FilterHeader(title: "Время отправления")
}
