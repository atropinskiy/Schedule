//
//  StoryView.swift
//  Schedule
//
//  Created by alex_tr on 27.01.2025.
//

import SwiftUI

struct StoryViewFullScreen: View {
    @ObservedObject private var viewModel: ScheduleViewModel
    @Environment(\.presentationMode) private var presentationMode
    @State private var timer: Timer?
    @State private var currentStoryIndex: Int
    @State private var progress: Double = 0
    @State private var dragOffset: CGFloat = 0
    @Namespace private var animationNamespace

    init(viewModel: ScheduleViewModel, storyIndex: Int) {
        self.viewModel = viewModel
        self.currentStoryIndex = storyIndex
    }

    var body: some View {
        ZStack {
            Image(viewModel.story[currentStoryIndex].imgName)
                .resizable()
                .cornerRadius(40)
                .offset(x: dragOffset)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            if value.translation.width < -50 {
                                nextStory()
                            } else if value.translation.width > 50 {
                                previousStory()
                            }
                            dragOffset = 0
                        }
                )
                .onTapGesture {
                    withAnimation {
                        dragOffset = -UIScreen.main.bounds.width
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        nextStory()
                    }
                }
                .contentShape(RoundedRectangle(cornerRadius: 40))

            VStack(spacing: 0) {
                HStack(spacing: 6) {
                    ForEach(Array(viewModel.story.enumerated()), id: \.offset) { index, _ in
                        ProgressView(value: index == currentStoryIndex ? progress : (index < currentStoryIndex ? 100 : 0), total: 100)
                            .progressViewStyle(LinearProgressViewStyle())
                            .background(Color.white)
                            .frame(height: 6)
                            .padding(.top, 12)
                            .cornerRadius(3)
                    }
                }

                HStack {
                    Spacer()
                    Image("closeStory")
                        .frame(width: 30, height: 30)
                        .background(Color.black)
                        .cornerRadius(15)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .padding(.top, 4)

                Spacer()

                Text(viewModel.story[currentStoryIndex].text1)
                    .font(.system(size: 34, weight: .bold))
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "storyTitle", in: animationNamespace)

                Text(viewModel.story[currentStoryIndex].text2)
                    .font(.system(size: 20, weight: .regular))
                    .lineLimit(3)
                    .foregroundColor(.white)
                    .padding(.top, 16)
                    .matchedGeometryEffect(id: "storyText", in: animationNamespace)
            }
            .padding(16)
        }
        .background(.black)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func startTimer() {
        progress = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if progress < 100 {
                progress += 2
            } else {
                nextStory()
            }
        }
    }

    private func nextStory() {
        guard currentStoryIndex + 1 < viewModel.story.count else {
            timer?.invalidate()
            return
        }

        timer?.invalidate()
        withAnimation {
            dragOffset = -UIScreen.main.bounds.width
        }

        currentStoryIndex += 1
        viewModel.setStoryShown(id: currentStoryIndex)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            dragOffset = 0
        }

        startTimer()
    }

    private func previousStory() {
        guard currentStoryIndex > 0 else { return }

        timer?.invalidate()
        withAnimation {
            dragOffset = UIScreen.main.bounds.width
        }

        currentStoryIndex -= 1
        viewModel.setStoryShown(id: currentStoryIndex)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            dragOffset = 0
        }

        startTimer()
    }
}

struct StoryViewFullScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScheduleViewModel()
        return StoryViewFullScreen(viewModel: viewModel, storyIndex: 0)
    }
}
