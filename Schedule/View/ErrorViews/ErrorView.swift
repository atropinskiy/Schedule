//
//  SwiftUIView.swift
//  Schedule
//
//  Created by alex_tr on 27.01.2025.
//

import SwiftUI

struct ErrorView: View {
    private var label: String
    private var imgName: String
    
    init(label: String, imgName: String) {
        self.label = label
        self.imgName = imgName
    }
    var body: some View {
        VStack (spacing: 16) {
            Image(imgName)
            Text(label)
                .font(.system(size: 24, weight: .bold))
        }
    }
}

#Preview {
    ErrorView(label: "Ошибка сервера", imgName: "error1")
}
