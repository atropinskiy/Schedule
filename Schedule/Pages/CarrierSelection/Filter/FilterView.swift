//
//  FilterView.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject private var viewModel: CarrierViewModel
    @State private var isOn = false
    @Environment(\.dismiss) private var dismiss
    init(viewModel: CarrierViewModel) {
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
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .padding(.horizontal, 16)
            if viewModel.transferFlag != nil && !viewModel.timeSelections.isEmpty {
                Button(action: {
                    dismiss()
                }) {
                    Text("Применить")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 17, weight: .bold))
                        .padding()
                        .background(Color("AT-blue"))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CarrierViewModel()
        return FilterView(viewModel: viewModel)
    }
}
