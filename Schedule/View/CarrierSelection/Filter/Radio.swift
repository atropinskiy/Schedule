//
//  Radio.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct Radio: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var isChecked = false
    private var flag: Bool
    private var text: String
    init(viewModel: ScheduleViewModel, text: String, flag: Bool) {
        self.viewModel = viewModel
        self.text = text
        self.flag = flag
    }
    
    var body: some View {
        HStack{
            Text(text)
                .font(.system(size: 17, weight: .regular))
            Spacer()
            Group {
                if viewModel.transferFlag != flag {
                    Image(systemName: "circle") // Радио кнопка, когда выбрано
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black) // Цвет для выбранного состояния
                } else {
                    Image("radio") // Замените на своё изображение для невыбранного состояния
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray) // Цвет для невыбранного состояния
                }
            }
            .onTapGesture {
                viewModel.transferFlag = flag
            }
            .padding(0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 60)
        
    }
}

struct Radio_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScheduleViewModel()
        return Radio(viewModel: viewModel, text: "Да", flag: true)
    }
}
