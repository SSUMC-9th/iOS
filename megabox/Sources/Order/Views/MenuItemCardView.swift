import SwiftUI

struct MenuItemCardView: View {
    let menuItem: MenuItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 이미지 영역
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("gray00"))
                .frame(width: 148, height: 148)
                .overlay(
                    Image(menuItem.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                )
                .cornerRadius(10)
                .bestBadge(menuItem.isBest)
                .recommendedBadge(menuItem.isRecommended)
                .soldout(menuItem.isSoldOut)
            
            // 텍스트 영역
            VStack(alignment: .leading, spacing: 4) {
                Text(menuItem.name)
                    .font(.regular13)
                    .foregroundStyle(.black)
                
                // 가격 표시
                if let originalPrice = menuItem.originalPrice {
                    HStack(spacing: 4) {
                        Text("\(formatPrice(menuItem.price))원")
                            .font(.semiBold14)
                            .foregroundStyle(.black)
                        
                        Text("\(formatPrice(originalPrice))원")
                            .font(.regular09)
                            .foregroundStyle(Color("gray04"))
                            .strikethrough()
                    }
                } else {
                    Text("\(formatPrice(menuItem.price))원")
                        .font(.semiBold14)
                        .foregroundStyle(.black)
                }
            }
        }
        .frame(width: 158)
    }
    
    private func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}

#Preview("BEST") {
    MenuItemCardView(menuItem: MenuItem(name: "러브 콤보", price: 10900, imageName: "love_combo", isBest: true))
}

#Preview("추천") {
    MenuItemCardView(menuItem: MenuItem(name: "메가박스 오리지널 티켓북", price: 10900, imageName: "ticket_book", isRecommended: true))
}

#Preview("품절") {
    MenuItemCardView(menuItem: MenuItem(name: "디즈니 픽사 포스터", price: 15900, imageName: "disney_pixar", isSoldOut: true))
}

#Preview("할인") {
    MenuItemCardView(menuItem: MenuItem(name: "인사이드아웃2 감정", price: 29900, imageName: "inside_out", originalPrice: 35900))
}

