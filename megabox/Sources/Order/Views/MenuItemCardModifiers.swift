import SwiftUI

// BEST 배지 ViewModifier
struct BestBadgeModifier: ViewModifier {
    let isBest: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content
            
            if isBest {
                Text("BEST")
                    .font(.medium10)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red)
                    .cornerRadius(4)
                    .padding(8)
            }
        }
    }
}

// 추천 배지 ViewModifier
struct RecommendedBadgeModifier: ViewModifier {
    let isRecommended: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content
            
            if isRecommended {
                Text("추천")
                    .font(.medium10)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .cornerRadius(4)
                    .padding(8)
            }
        }
    }
}

// 품절 ViewModifier
struct SoldOutModifier: ViewModifier {
    let isSoldOut: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isSoldOut {
                Color.black.opacity(0.5)
                    .cornerRadius(10)
                
                Text("품절")
                    .font(.bold18)
                    .foregroundColor(.white)
            }
        }
    }
}

// 할인율 ViewModifier
struct DiscountModifier: ViewModifier {
    let discountRate: Int?
    
    func body(content: Content) -> some View {
        content
    }
}

// View 확장 메서드
extension View {
    func bestBadge(_ isBest: Bool) -> some View {
        self.modifier(BestBadgeModifier(isBest: isBest))
    }
    
    func recommendedBadge(_ isRecommended: Bool) -> some View {
        self.modifier(RecommendedBadgeModifier(isRecommended: isRecommended))
    }
    
    func soldout(_ isSoldOut: Bool) -> some View {
        self.modifier(SoldOutModifier(isSoldOut: isSoldOut))
    }
    
    func discount(_ discountRate: Int?) -> some View {
        self.modifier(DiscountModifier(discountRate: discountRate))
    }
}

