import SwiftUI

private struct BestBadgeModifier: ViewModifier {
    let isBest: Bool
    
    func body(content: Content) -> some View {
        content.overlay(alignment: .topLeading) {
            if isBest {
                BadgeLabel(text: "BEST", background: Color.orange)
                    .padding(12)
            }
        }
    }
}

private struct RecommendationBadgeModifier: ViewModifier {
    let isRecommended: Bool
    
    func body(content: Content) -> some View {
        content.overlay(alignment: .bottomLeading) {
            if isRecommended {
                BadgeLabel(text: "추천", background: Color.purple.opacity(0.8))
                    .padding([.leading, .bottom], 12)
            }
        }
    }
}

private struct DiscountBadgeModifier: ViewModifier {
    let discountRate: Int?
    
    func body(content: Content) -> some View {
        content.overlay(alignment: .topTrailing) {
            if let discountRate {
                BadgeLabel(text: "-\(discountRate)%", background: Color.red)
                    .padding(12)
            }
        }
    }
}

private struct SoldOutOverlayModifier: ViewModifier {
    let isSoldOut: Bool
    
    func body(content: Content) -> some View {
        content.overlay {
            if isSoldOut {
                ZStack {
                    Color.black.opacity(0.4)
                        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    Text("현재 품절")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

private struct BadgeLabel: View {
    let text: String
    let background: Color
    
    var body: some View {
        Text(text)
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .foregroundStyle(Color.white)
            .background(
                Capsule(style: .continuous)
                    .fill(background)
            )
    }
}

private struct InfoCardModifier: ViewModifier {
    var background: Color
    var strokeColor: Color
    var cornerRadius: CGFloat
    
    init(background: Color = Color.white, strokeColor: Color = Color.black.opacity(0.1), cornerRadius: CGFloat = 28) {
        self.background = background
        self.strokeColor = strokeColor
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(background)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(strokeColor.opacity(0.12), lineWidth: 1)
            )
    }
}

extension View {
    func bestBadge(_ isBest: Bool) -> some View {
        modifier(BestBadgeModifier(isBest: isBest))
    }
    
    func recommendedBadge(_ isRecommended: Bool) -> some View {
        modifier(RecommendationBadgeModifier(isRecommended: isRecommended))
    }
    
    func discountBadge(_ discountRate: Int?) -> some View {
        modifier(DiscountBadgeModifier(discountRate: discountRate))
    }
    
    func soldOutOverlay(_ isSoldOut: Bool) -> some View {
        modifier(SoldOutOverlayModifier(isSoldOut: isSoldOut))
    }
    
    func infoCard(
        background: Color = Color.white,
        strokeColor: Color = Color.black.opacity(0.1),
        cornerRadius: CGFloat = 28
    ) -> some View {
        modifier(InfoCardModifier(background: background, strokeColor: strokeColor, cornerRadius: cornerRadius))
    }
}

