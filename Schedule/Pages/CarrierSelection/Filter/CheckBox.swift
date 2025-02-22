//
//  CheckBoxAndRadio.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct CheckBox: View {
    @ObservedObject private var viewModel: CarrierViewModel
    @State private var isChecked: Bool
    private var text: String
    init(viewModel: CarrierViewModel, text: String) {
        self.viewModel = viewModel
        self.text = text
        _isChecked = State(initialValue: viewModel.timeSelections.contains(text))
    }
    
    var body: some View {
        HStack{
            Text(text)
                .font(.system(size: 17, weight: .regular))
            Spacer()
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(Color("AT-black-DN"))
                .onTapGesture {
                    isChecked.toggle()
                    if isChecked {
                        viewModel.timeSelections.append(text)
                    } else {
                        if let index = viewModel.timeSelections.firstIndex(of: text) {
                            viewModel.timeSelections.remove(at: index)
                            
                        }
                    }
                    print(viewModel.timeSelections)
                    
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 60)
        
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CarrierViewModel()
        return CheckBox(viewModel: viewModel, text: "Утро 06:00 - 12:00")
    }
}
