//
//  StoryView.swift
//  Schedule
//
//  Created by alex_tr on 27.01.2025.
//

import SwiftUI

struct StoryViewFullScreen: View {
    @ObservedObject private var viewModel: StoryViewModel
    @Environment(\.presentationMode) private var presentationMode
    private var currentStoryIndex: Int
    @Namespace private var animationNamespace

    init(viewModel: StoryViewModel, storyIndex: Int) {
        self.viewModel = viewModel
        self.currentStoryIndex = storyIndex
    }

    var body: some View {
        ZStack {
            Image(viewModel.story[currentStoryIndex].imgName)
                .resizable()
                .cornerRadius(40)
                .offset(x: viewModel.dragOffset)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            viewModel.dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            if value.translation.width < -50 {
                                viewModel.nextStory()
                            } else if value.translation.width > 50 {
                                viewModel.previousStory()
                            }
                            viewModel.dragOffset = 0
                        }
                )
                .onTapGesture {
                    withAnimation {
                        viewModel.dragOffset = -UIScreen.main.bounds.width
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        viewModel.nextStory()
                    }
                }
                .contentShape(RoundedRectangle(cornerRadius: 40))

            VStack(spacing: 0) {
                HStack(spacing: 6) {
                    ForEach(Array(viewModel.story.enumerated()), id: \.offset) { index, _ in
                        ProgressView(value: index == currentStoryIndex ? viewModel.progress : (index < currentStoryIndex ? 100 : 0), total: 100)
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
            viewModel.startTimer()
        }
        .onDisappear {
            viewModel.timer?.invalidate()
        }
    }
}

struct StoryViewFullScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = StoryViewModel(currentStoryIndex: 1)
        return StoryViewFullScreen(viewModel: viewModel, storyIndex: 0)
    }
}
