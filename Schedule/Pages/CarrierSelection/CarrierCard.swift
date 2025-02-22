//
//  CarrierCard.swift
//  Schedule
//
//  Created by alex_tr on 25.01.2025.
//

import SwiftUI

struct CarrierCard: View {
    private var cardCarrier: CarrierModel

    init(cardCarrier: CarrierModel) {
        self.cardCarrier = cardCarrier
    }

    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                HStack(spacing: 8) {
                    CarrierImageView(iconURL: cardCarrier.iconName)

                    VStack {
                        Text(cardCarrier.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                        if let hasTransfers = cardCarrier.hasTransfers, !hasTransfers.isEmpty {
                            Text(hasTransfers)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.red)
                                .font(.system(size: 12, weight: .regular))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack {
                        Text(cardCarrier.formattedDate())
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 7)
                    .padding(.bottom, 15)
                    .frame(maxWidth: 100, alignment: .topTrailing)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack {
                Text(cardCarrier.trimmedTimeStart())
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.black)
                Image("Separator")
                Text("\(Int(cardCarrier.duration / 60 / 60)) Часов")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black)
                Image("Separator")
                Text(cardCarrier.trimmedTimeFinish())
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.black)
            }
            .frame(height: 48)
        }
        .padding(.horizontal, 14)
        .padding(.top, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 104)
        .background(Color("AT-lightGray"))
        .cornerRadius(24)
        .zIndex(2)
        .contentShape(Rectangle())
    }
}

private struct CarrierImageView: View {
    let iconURL: String

    enum CarrierImageState {
        case loading
        case success(Image)
        case failure

        init(_ phase: AsyncImagePhase) {
            switch phase {
            case .empty:
                self = .loading
            case .success(let image):
                self = .success(image)
            case .failure:
                self = .failure
            @unknown default:
                self = .failure
            }
        }
    }

    var body: some View {
        if let url = URL(string: iconURL), !iconURL.isEmpty {
            AsyncImage(url: url) { phase in
                let state = CarrierImageState(phase)
                switch state {
                case .loading:
                    ProgressView().frame(width: 40, height: 40)
                case .success(let image):
                    image.resizable().scaledToFit().frame(width: 40, height: 40)
                case .failure:
                    EmptyView()
                }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    CarrierCard(cardCarrier: CarrierModel(
        name: "РЖД",
        transfer: "С пересадкой в Костроме",
        timeStart: "22:30",
        timeFinish: "08:15",
        duration: 15.02,
        iconName: "RZD",
        date: "14 января",
        carrierCode: 146
    ))
}
