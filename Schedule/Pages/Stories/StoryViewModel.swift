//
//  StoryViewModel.swift
//  Schedule
//
//  Created by alex_tr on 22.02.2025.
//
import SwiftUI

@MainActor
class StoryViewModel: ObservableObject {
    
    @Published var selectedStoryIndex: Int?
    @Published var showingStories: Bool = false
    @Published var currentStoryIndex: Int
    @Published var story: [Story]
    @Published var dragOffset: CGFloat = 0
    @Published var progress: Double = 0
    @Published var timer: Timer?

    init(currentStoryIndex: Int) {
        
        let story1 = Story(
            name: "Story1",
            imgName: "story1_FS",
            shown: false,
            text1: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )
        let story2 = Story(
            name: "Story2",
            imgName: "story2_FS",
            shown: false,
            text1: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )
        let story3 = Story(
            name: "Story3",
            imgName: "story3_FS",
            shown: false,
            text1: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )
        let story4 = Story(
            name: "Story3",
            imgName: "story1_FS",
            shown: false,
            text1: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )
        let story5 = Story(
            name: "Story3",
            imgName: "story2_FS",
            shown: false,
            text1: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText",
            text2: "TextTextTextTextTextTextTextTextTextTextTextTextTextTextText"
        )
       
        
        self.story = [story1, story2, story3, story4, story5]
        self.currentStoryIndex = currentStoryIndex
    }
    
    func selectStory(at index: Int) {
        selectedStoryIndex = index
        currentStoryIndex = index // ✅ Устанавливаем текущую историю
        showingStories = true
    }
    
    func closeStory() {
        showingStories = false
        selectedStoryIndex = nil
    }
    
    func setStoryShown(id: Int) {
        if story.indices.contains(id) {
            story[id].shown = true
            objectWillChange.send() // Обновляем View
        }
    }
    
    func startTimer() {
        progress = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] _ in
            Task { @MainActor in
                if progress < 100 {
                    progress += 2
                } else {
                    nextStory()
                }
            }
        }
    }


    func nextStory() {
        guard currentStoryIndex + 1 < story.count else {
            timer?.invalidate()
            return
        }

        timer?.invalidate()
        withAnimation {
            dragOffset = -UIScreen.main.bounds.width
        }

        currentStoryIndex += 1
        selectedStoryIndex = currentStoryIndex // ✅ Обновляем индекс выбранной истории
        setStoryShown(id: currentStoryIndex)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dragOffset = 0
        }

        startTimer()
    }


    func previousStory() {
        guard currentStoryIndex > 0 else { return }

        timer?.invalidate()
        withAnimation {
            dragOffset = UIScreen.main.bounds.width
        }

        currentStoryIndex -= 1
        selectedStoryIndex = currentStoryIndex // ✅ Обновляем индекс выбранной истории
        setStoryShown(id: currentStoryIndex)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dragOffset = 0
        }

        startTimer()
    }
}
