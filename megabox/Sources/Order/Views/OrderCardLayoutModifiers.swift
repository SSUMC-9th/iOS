import SwiftUI

// 기본 카드 스타일 Modifier
struct OrderCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("gray02"), lineWidth: 1)
            )
    }
}

// 레이아웃 Modifier: 텍스트 왼쪽 상단, 아이콘 오른쪽 하단 (바로 주문 / 선물하기 / 스토어 교환권)
struct TopLeftTextLayoutStyle: ViewModifier {
    let title: String
    let description: String?
    let iconName: String
    let iconSize: CGFloat
    let titleFont: Font
    
    init(title: String, description: String?, iconName: String, iconSize: CGFloat, titleFont: Font = .bold24) {
        self.title = title
        self.description = description
        self.iconName = iconName
        self.iconSize = iconSize
        self.titleFont = titleFont
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            // 카드 배경
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("gray02"), lineWidth: 1)
                )
            
            // 텍스트 (왼쪽 상단)
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(titleFont)
                    .foregroundColor(.black)
                
                if let description = description {
                    Text(description)
                        .font(.regular12)
                        .foregroundColor(Color("gray04"))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 15)
            
            // 아이콘 (오른쪽 하단)
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Image(systemName: iconName)
                        .font(.system(size: iconSize, weight: .light))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 15)
        }
        .modifier(OrderCardStyle())
    }
}

// 레이아웃 Modifier: 텍스트 왼쪽, 아이콘 오른쪽 가로 배치 (어디서든 팝콘 만나기용)
struct HorizontalLayoutStyle: ViewModifier {
    let title: String
    let description: String?
    let iconName: String
    let iconSize: CGFloat
    let iconBackgroundColor: Color?
    let titleFont: Font
    
    init(title: String, description: String?, iconName: String, iconSize: CGFloat, iconBackgroundColor: Color?, titleFont: Font = .bold24) {
        self.title = title
        self.description = description
        self.iconName = iconName
        self.iconSize = iconSize
        self.iconBackgroundColor = iconBackgroundColor
        self.titleFont = titleFont
    }
    
    func body(content: Content) -> some View {
        ZStack {
            // 카드 배경
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("gray02"), lineWidth: 1)
                )
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(titleFont)
                        .foregroundColor(.black)
                    
                    if let description = description {
                        Text(description)
                            .font(.regular13)
                            .foregroundColor(Color("gray04"))
                    }
                }
                
                Spacer()
                
                // 아이콘
                Image(systemName: iconName)
                    .font(.system(size: iconSize, weight: .light))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 15)
        }
        .modifier(OrderCardStyle())
    }
}

