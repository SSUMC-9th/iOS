import SwiftUI

struct DeliverySectionView: View {
    var body: some View {
        EmptyView()
            .modifier(HorizontalLayoutStyle(
                title: "어디서든 팝콘 만나기",
                description: "팝콘 콜라 스낵 모든 메뉴 배달 가능!",
                iconName: "moped",
                iconSize: 50,
                iconBackgroundColor: nil,
                titleFont: .bold22
            ))
    }
}

#Preview {
    DeliverySectionView()
}

