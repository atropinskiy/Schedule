//
//  FilterView.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var isOn = false
    @Environment(\.dismiss) var dismiss
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            List {
                Section(header: FilterHeader(title: "Время отправления").listRowInsets(EdgeInsets())) {
                    VStack (spacing:0) {
                        CheckBox(viewModel: viewModel, text: "Утро 06:00-12:00")
                        CheckBox(viewModel: viewModel, text: "День 12:00-18:00")
                        CheckBox(viewModel: viewModel, text: "Вечер 18:00-00:00")
                        CheckBox(viewModel: viewModel, text: "Ночь 00:00-06:00")
                    }
                    .listRowInsets(EdgeInsets())
                }
                .padding(.top, 16)
                .padding(.horizontal, 0)
                .listRowBackground(Color.clear)
                .background(Color.clear)
                .listRowSeparator(.hidden)
                Section(header: FilterHeader(title: "Показывать варианты с пересадками").listRowInsets(EdgeInsets())) {
                    VStack (spacing:0) {
                        Radio(viewModel: viewModel, text: "Да", flag: true)
                        Radio(viewModel: viewModel, text: "Нет", flag: false)
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 0)
                    .lineLimit(2)
                }
            }
            .listStyle(.plain)
            .padding(.horizontal, 16)
            if viewModel.transferFlag != nil && !viewModel.timeSelections.isEmpty {
                Button(action: {
                    dismiss()
                }) {
                    Text("Применить") // Текст кнопки
                        .frame(maxWidth: .infinity) // Чтобы кнопка растягивалась по ширине
                        .font(.system(size: 17, weight: .bold))
                        .padding()
                        .background(Color("AT-blue")) // Цвет фона кнопки
                        .foregroundColor(.white) // Цвет текста
                        .cornerRadius(16) // Округление углов кнопки
                }
                .padding(.horizontal, 16) // Отступы от краев экрана
                .padding(.bottom, 24) // Отступ снизу
            }
        }
        
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScheduleViewModel()
        return FilterView(viewModel: viewModel)
    }
}
