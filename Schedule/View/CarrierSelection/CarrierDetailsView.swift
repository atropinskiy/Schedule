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
        Text(carrier)
    }
}

#Preview {
    CarrierDetailsView(carrier: "РЖД")
}
