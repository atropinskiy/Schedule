//
//  StoryView.swift
//  Schedule
//
//  Created by alex_tr on 24.01.2025.
//

import SwiftUI

struct StoryView: View {
    var imgName: Story
    var body: some View {
        Image(imgName.name)
    }
}

#Preview {
    StoryView(imgName: Story(name: "Story1"))
}
