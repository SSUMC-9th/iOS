import SwiftUI

struct MobileOrderView: View {
    
    @State private var selectedTheater: String = "강남"
    @State private var selectedItem: MenuItemModel?
    
    private let promoCards: [PromoCardModel] = [
        .primary(title: "바로 주문", subtitle: "이제 줄서지 말고\n모바일로 주문하고 픽업!", icon: "popcorn"),
        .secondary(title: "스토어 교환권", icon: "ticket.fill"),
        .secondary(title: "선물하기", icon: "gift.fill")
    ]
    
    private let deliveryCard = DeliveryCardModel(
        title: "어디서든 팝콘 만나기",
        subtitle: "팝콘 콜라 스낵 모든 메뉴 배달 가능!",
        icon: "figure.walk.motion"
    )
    
    private let recommendedMenuOrder = ["싱글 콤보", "러브 콤보", "디즈니 픽사 포스터"]
    private let bestMenuOrder = [
        "더블 콤보",
        "러브 콤보 패키지",
        "패밀리 콤보 패키지",
    ]
    
    private var recommendedMenus: [MenuItemModel] {
        orderedDetailItems(by: recommendedMenuOrder)
    }
    
    private var bestMenus: [MenuItemModel] {
        orderedDetailItems(by: bestMenuOrder)
    }
    
    private func orderedDetailItems(by order: [String]) -> [MenuItemModel] {
        let lookup = Dictionary(uniqueKeysWithValues: MenuItemModel.detailPageItems.map { ($0.name, $0) })
        return order.compactMap { lookup[$0] }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    logoHeader
                    
                    TheaterChangeBar(
                        currentTheater: selectedTheater,
                        subTitle: "",
                        actionTitle: "극장 변경",
                        action: { }
                    )
                    .theaterChangeBarTheme(.highlight)
                    
                    promoSection
                    
                    deliverySection
                    
                    menuSection(
                        title: "추천 메뉴",
                        subtitle: "영화 볼때 뭐먹지 고민될 땐 추천 메뉴!",
                        items: recommendedMenus
                    )
                    
                    menuSection(
                        title: "베스트 메뉴",
                        subtitle: "영화 볼때 뭐먹지 고민될 때 베스트 메뉴!",
                        items: bestMenus
                    )
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
            }
            .background(Color.white.ignoresSafeArea())
            .navigationDestination(item: $selectedItem) { item in
                MobileOrderDetailView(item: item)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
    private var logoHeader: some View {
        HStack {
            Image("megaboxLogo2")
            Spacer()
        }
    }
    
    private var promoSection: some View {
        GeometryReader { proxy in
            let totalWidth = proxy.size.width
            let primaryWidth = totalWidth * 0.58
            let secondaryWidth = totalWidth - primaryWidth - 12
            
            HStack(alignment: .top, spacing: 12) {
                if let first = promoCards.first {
                    PrimaryPromoCard(card: first)
                        .frame(width: primaryWidth)
                        .onTapGesture {
                            navigateToDefaultDetailItem()
                        }
                }
                
                VStack(spacing: 12) {
                    ForEach(promoCards.dropFirst()) { card in
                        SecondaryPromoCard(card: card)
                            .frame(width: secondaryWidth, height: 145)
                    }
                }
            }
        }
        .frame(height: 320)
    }
    
    private var deliverySection: some View {
        DeliveryInfoCard(card: deliveryCard)
    }
    
    private func menuSection(title: String, subtitle: String, items: [MenuItemModel]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title3.bold())
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        MenuThumbnailCard(item: item)
                            .onTapGesture {
                                selectedItem = item
                            }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
    
    private func navigateToDefaultDetailItem() {
        if let target = MenuItemModel.detailPageItems.first {
            selectedItem = target
        } else if let fallback = MenuItemModel.sampleItems.first {
            selectedItem = fallback
        }
    }
}

// MARK: - Models

private struct PromoCardModel: Identifiable {
    enum CardType {
        case primary
        case secondary
    }
    
    let id = UUID()
    let type: CardType
    let title: String
    let subtitle: String
    let icon: String
    
    static func primary(title: String, subtitle: String, icon: String) -> PromoCardModel {
        PromoCardModel(type: .primary, title: title, subtitle: subtitle, icon: icon)
    }
    
    static func secondary(title: String, icon: String) -> PromoCardModel {
        PromoCardModel(type: .secondary, title: title, subtitle: "", icon: icon)
    }
}

private struct DeliveryCardModel {
    let title: String
    let subtitle: String
    let icon: String
}

// MARK: - Promo Cards

private struct PrimaryPromoCard: View {
    let card: PromoCardModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(card.title)
                    .font(.system(size: 24, weight: .bold))
                Text(card.subtitle)
                    .font(.footnote)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            Image(systemName: card.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundStyle(Color.black.opacity(0.8))
        }
        .padding(16)
        .frame(maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color(red: 0.79, green: 0.77, blue: 0.77), lineWidth: 1)
        )
    }
}

private struct SecondaryPromoCard: View {
    let card: PromoCardModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(card.title)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.black)
            
            Spacer()
            
            Image(systemName: card.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 46, height: 46)
                .foregroundStyle(.black)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color(red: 0.79, green: 0.77, blue: 0.77), lineWidth: 1)
        )
    }
}

private struct DeliveryInfoCard: View {
    let card: DeliveryCardModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(card.title)
                    .font(.system(size: 22, weight: .bold))
                Text(card.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: card.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.black.opacity(0.7))
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color(red: 0.79, green: 0.77, blue: 0.77), lineWidth: 1)
        )
    }
}

// MARK: - Menu Thumbnails

private struct MenuThumbnailCard: View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                MenuItemPreviewImage(
                    imageName: item.heroImageName,
                    cornerRadius: 12,
                    height: 160
                )
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.subheadline)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                HStack(spacing: 6) {
                    Text("\(item.formattedPrice)원")
                        .font(.callout.bold())
                        .foregroundStyle(.black)
                    if let origin = item.originalPrice {
                        Text("\(origin.formattedWithComma)원")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                            .strikethrough()
                    }
                }
            }
        }
        .frame(width: 160, alignment: .leading)
    }
}

private struct MenuItemPreviewImage: View {
    let imageName: String?
    let cornerRadius: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(Color(red: 0.97, green: 0.97, blue: 0.97))
            if let imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(8)
            } else {
                ImagePlaceholder()
            }
        }
        .frame(height: height)
    }
}

@ViewBuilder
private func statusBadge(for item: MenuItemModel) -> some View {
    if item.isBest {
        badgeLabel(text: "BEST", color: Color(red: 0.93, green: 0.3, blue: 0.34))
    } else if item.isRecommended {
        badgeLabel(text: "추천", color: Color(red: 0.14, green: 0.48, blue: 0.78))
    } else {
        EmptyView()
    }
}

private func badgeLabel(text: String, color: Color) -> some View {
    Text(text)
        .font(.system(size: 12, weight: .semibold))
        .foregroundStyle(Color.white)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
}

private struct ImagePlaceholder: View {
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: "photo")
                .font(.title2)
            Text("이미지를\n추가해주세요")
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(Color.gray)
    }
}

#Preview {
    MobileOrderView()
}

