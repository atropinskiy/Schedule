//
//  SwiftUIView.swift
//  Schedule
//
//  Created by alex_tr on 27.01.2025.
//

import SwiftUI

struct ErrorView: View {
    private var errorType: ErrorType
    
    init(errorType: ErrorType) {
        self.errorType = errorType
    }
    var body: some View {
        VStack (spacing: 16) {
            Image(errorType.errorModel.imgName)
            Text(errorType.errorModel.label)
                .font(.system(size: 24, weight: .bold))
        }
    }
}

#Preview {
    ErrorView(errorType: ErrorType.internet_error)
}
