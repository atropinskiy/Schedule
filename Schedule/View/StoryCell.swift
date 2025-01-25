//
//  StoryCell.swift
//  Schedule
//
//  Created by alex_tr on 27.12.2024.
//

import SwiftUI

struct StoryCell: View {
    let item: String
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .background(Color.gray.opacity(0.3))
                .clipShape(Circle())
            
            Text(item)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(width: 92, height: 140)
        .background(Color(.green))
        .cornerRadius(16)
    }
}
