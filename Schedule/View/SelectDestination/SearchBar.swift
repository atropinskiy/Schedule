import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    @State private var isSearching: Bool = false
    @State private var isEditing: Bool = false
    var placeholder = "Введите запрос"
    
    var body: some View {
        HStack (spacing: 0) {
            HStack (spacing: 0) {
                TextField(placeholder, text: $searchText)
                    .font(.system(size: 17))
                    .padding(.leading, 8)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .onTapGesture {
                        isSearching = true
                        isEditing = true
                    }
                    .onChange(of: searchText) { _ in
                        if searchText.isEmpty {
                            isSearching = false
                        } else {
                            isSearching = true
                        }
                    }

                if isSearching && !searchText.isEmpty {
                    Button(action: {
                        // Очищаем текст и снимаем фокус с текстового поля
                        searchText = ""
                        isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.vertical)
                    }
                    .padding(.trailing, 8)
                }
            }
            .frame(height: 37)
            .padding(.horizontal)
            .background(Color("AT-searchBarBg-DN"))
            .cornerRadius(10)
            .onTapGesture {
                // Снимаем фокус, если пользователь кликает вне поля ввода
                if isEditing {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    isEditing = false
                }
            }
            
        }
        .frame(height: 37)
        .contentShape(Rectangle())
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper("Пример текста") { searchText in
            SearchBar(searchText: searchText)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}

struct StatefulPreviewWrapper<Value: Equatable, Content: View>: View {
    @State private var value: Value
    private let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        _value = State(wrappedValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
