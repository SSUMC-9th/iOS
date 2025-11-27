import SwiftUI

struct GiftCardView: View {
    var body: some View {
        EmptyView()
            .modifier(TopLeftTextLayoutStyle(
                title: "선물하기",
                description: nil,
                iconName: "gift",
                iconSize: 50,
                titleFont: .bold22
            ))
    }
}

#Preview {
    GiftCardView()
        .padding()
}

