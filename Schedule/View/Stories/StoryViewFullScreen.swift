//
//  StoryView.swift
//  Schedule
//
//  Created by alex_tr on 27.01.2025.
//

import SwiftUI

struct StoryViewFullScreen: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @Environment(\.presentationMode) var presentationMode
    private var story: Story
    
    
    init(viewModel: ScheduleViewModel, story: Story) {
        print("Initializing Story")
        self.viewModel = viewModel
        self.story = story
    }
    
    var body: some View {
        ZStack{
            Image(story.imgName)
                .resizable()
                .cornerRadius(40)
            
            VStack (spacing:0){
                HStack (spacing:6) {
                    ForEach(viewModel.story) { _ in
                        ProgressView(value: 50, total: 100)
                            .progressViewStyle(LinearProgressViewStyle())
                            .background(Color.white)
                            .frame(height: 6) // Высота полосы
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
                Text(story.name)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("TextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextTextText")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.top, 16)
                
            }
            .padding(16)
            
            
        }
        .background(.black)
        .onAppear {
            print("StoryView appeared with story: \(story.name)")
        }
    }
}

struct StoryViewFullScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScheduleViewModel()
        return StoryViewFullScreen(viewModel: viewModel, story: viewModel.story[0])
    }
}
