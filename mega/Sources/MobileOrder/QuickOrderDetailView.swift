//
//  QuickOrderDetailView.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//

import Foundation
import SwiftUI

struct QuickOrderDetailView: View {
    @Environment(\.dismiss) private var dismiss


    private let items: [MenuItemModel] = [
        .init(title: "싱글 콤보", price: 10900, imageName: "singleCombo",
              isBest: true, isRecommended: false, isSoldOut: false, discountRate: nil),
        .init(title: "러브 콤보", price: 10900, imageName: "loveCombo",
              isBest: true, isRecommended: false, isSoldOut: false, discountRate: nil),
        .init(title: "더블 콤보", price: 24900, imageName: "doubleCombo",
              isBest: false, isRecommended: false, isSoldOut: false, discountRate: 10),
        .init(title: "러브 콤보 패키지", price: 32000, imageName: "loveComboPack",
              isBest: false, isRecommended: true, isSoldOut: false, discountRate: nil),
        .init(title: "패밀리 콤보 패키지", price: 15000, imageName: "familyComboPack",
              isBest: false, isRecommended: false, isSoldOut: true, discountRate: nil),
        .init(title: "메가박스 오리지널 시즌북", price: 15000, imageName: "ticketBook",
              isBest: false, isRecommended: false, isSoldOut: true, discountRate: nil)
    ]

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                header
                TheaterLocationBar(theaterName: "강남")
                    .theaterBarStyle(.white)

                Divider()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(items) { item in
                            MenuItemCard(item: item)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
            }
        }.navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.black)
                    .frame(width: 32, height: 32)
                    .background(Color.white)
                    .clipShape(Circle())
            }

            Spacer()

            Text("바로주문")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Button {
                // 장바구니 액션
            } label: {
                Image(systemName: "cart")
                    .font(.system(size: 20))
                    .foregroundStyle(.black)
                    .frame(width: 32, height: 32)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(Color.white)
    }
}

#Preview {
    QuickOrderDetailView()
}
