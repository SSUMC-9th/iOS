//
//  MenuItemModel.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//

import Foundation
import SwiftUI

struct MenuItemModel: Identifiable {
    let id = UUID()
    let title: String
    let price: Int
    let imageName: String
}

struct RecommendedMenuCard: View {
    let item: MenuItemModel

    var body: some View {
        VStack(alignment: .leading) {
            // 상단 이미지
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 152, height: 152)
                .clipped()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(item.title)
                .font(.system(size: 13))
                

            Text("\(item.price.formatted(.number.grouping(.automatic)))원")
                .font(.system(size: 15, weight: .bold))
        }
        .frame(width: 158)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview{
    RecommendedMenuCard(item: MenuItemModel(
        title: "러브 콤보",
        price: 10900,
        imageName: "loveCombo"
    ))
}
