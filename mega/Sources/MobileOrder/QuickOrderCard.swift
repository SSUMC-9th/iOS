//
//  QuickOrderCard.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//

import SwiftUI

struct QuickOrderCard: View {
    let title: String
    let description: String
    let iconName: String

    var body: some View {
        OrderCard {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.system(size: 22, weight: .bold))

                Text(description)
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)

                Spacer()

                HStack {
                    Spacer()
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                }
            }
        }
    }
}


#Preview {
    QuickOrderCard(
        title: "바로 주문",
        description: "이제 줄서지 말고\n모바일로 주문하고 픽업!",
        iconName: "popcorn"
    )
    .frame(width: 250, height: 220)
}

