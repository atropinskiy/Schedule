//
//  AgreementView.swift
//  Schedule
//
//  Created by alex_tr on 27.01.2025.
//

import SwiftUI

struct AgreementView: View {
    @State private var isTabBarHidden: Bool = true
    @Environment(\.dismiss) private var dismiss
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(named: "AT-bg-DN")
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing:8) {
                Text("Оферта на оказание образовательных услуг дополнительного образования Яндекс.Практикум для физических лиц")
                    .padding(0)
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("AT-black-DN"))
                Text("Данный документ является действующим, если расположен по адресу: https://yandex.ru/legal/practicum_offer Российская Федерация, город Москва")
                    .padding(0)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color("AT-black-DN"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("1. ТЕРМИНЫ")
                    .padding(0)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("AT-black-DN"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("""
                     Понятия, используемые в Оферте, означают следующее:  Авторизованные адреса — адреса электронной почты каждой Стороны. Авторизованным адресом Исполнителя является адрес электронной почты, указанный в разделе 11 Оферты. Авторизованным адресом Студента является адрес электронной почты, указанный Студентом в Личном кабинете.  Вводный курс — начальный Курс обучения по представленным на Сервисе Программам обучения в рамках выбранной Студентом Профессии или Курсу, рассчитанный на определенное количество часов самостоятельного обучения, который предоставляется Студенту единожды при регистрации на Сервисе на безвозмездной основе. В процессе обучения в рамках Вводного курса Студенту предоставляется возможность ознакомления с работой Сервиса и определения возможности Студента продолжить обучение в рамках Полного курса по выбранной Студентом Программе обучения. Точное количество часов обучения в рамках Вводного курса зависит от выбранной Студентом Профессии или Курса и определяется в Программе обучения, размещенной на Сервисе. Максимальный срок освоения Вводного курса составляет 1 (один) год с даты начала обучения.
                     
                     """)
                .padding(0)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color("AT-black-DN"))
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(16)
            .navigationTitle("Пользовательское соглашение")
            .toolbar(isTabBarHidden ? .hidden : .visible, for: .tabBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color("AT-black-DN"))
                            .padding(.horizontal, 0)
                    }
                }
            }
            
        }
    }
    
}

#Preview {
    AgreementView()
}
