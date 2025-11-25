//
//  OrderCard.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//

import SwiftUI

struct OrderCard<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                )
            content()
                .padding(20)
        }
    }
}

struct MenuItemCard: View {
    let item: MenuItemModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 170)
                .frame(maxWidth: .infinity)
                .clipped()
                .background(Color("gray02"))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .bestBadge(item.isBest ?? false)
                .recommendBadge(item.isRecommended ?? false)
                .discountBadge(item.discountRate)
                .soldOutOverlay(item.isSoldOut)

            // 메뉴 이름
            Text(item.title)
                .font(.system(size: 14))
                .foregroundStyle(.black)

            // 가격
            Text("\(item.price.formatted(.number.grouping(.automatic)))원")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.black)
        }
        .padding(12)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 3)
    }
}

#Preview {
    MenuItemCard(
        item: MenuItemModel(
            title: "싱글 콤보",
            price: 10900,
            imageName: "singleCombo",
            isBest: true,
            isRecommended: false,
            isSoldOut: false,
            discountRate: nil
        )
    )
    .frame(width: 170)
    .previewLayout(.sizeThatFits)
}



