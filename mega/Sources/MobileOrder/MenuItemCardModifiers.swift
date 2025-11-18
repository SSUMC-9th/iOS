//
//  MenuItemCardModifiers.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//

import Foundation
import SwiftUI

struct BestBadgeModifier: ViewModifier {
    let isBest: Bool

    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content

            if isBest {
                Text("BEST")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .offset(x: 0, y: 0)
            }
        }
    }
}


struct RecommendBadgeModifier: ViewModifier {
    let isRecommended: Bool

    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content

            if isRecommended {
                Text("추천")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .offset(x: 0, y: 0)
            }
        }
    }
}

struct DiscountBadgeModifier: ViewModifier {
    let rate: Int?

    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content

            if let rate, rate > 0 {
                Text("\(rate)%")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .offset(x: 0, y: 0)
            }
        }
    }
}

struct SoldOutOverlayModifier: ViewModifier {
    let isSoldOut: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
                .overlay(
                    isSoldOut ?
                    Rectangle()
                        .foregroundStyle(Color.black.opacity(0.55))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    : nil
                )

            if isSoldOut {
                Text("품절")
                    .font(.PretendardRegular16)
                    .foregroundColor(.white)
            }
        }
    }
}


extension View {
    func bestBadge(_ isBest: Bool) -> some View {
        modifier(BestBadgeModifier(isBest: isBest))
    }

    func recommendBadge(_ isRecommended: Bool) -> some View {
        modifier(RecommendBadgeModifier(isRecommended: isRecommended))
    }

    func discountBadge(_ rate: Int?) -> some View {
        modifier(DiscountBadgeModifier(rate: rate))
    }

    func soldOutOverlay(_ isSoldOut: Bool) -> some View {
        modifier(SoldOutOverlayModifier(isSoldOut: isSoldOut))
    }
}
