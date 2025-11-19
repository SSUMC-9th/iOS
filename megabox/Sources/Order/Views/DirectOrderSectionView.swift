import SwiftUI

struct DirectOrderSectionView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        Button {
            router.push(.directOrderDetail)
        } label: {
            EmptyView()
                .modifier(TopLeftTextLayoutStyle(
                    title: "바로 주문",
                    description: "이제 줄서지 말고\n모바일로 주문하고 픽업!",
                    iconName: "popcorn",
                    iconSize: 50
                ))
        }
    }
}

#Preview {
    DirectOrderSectionView()
        .padding()
}
