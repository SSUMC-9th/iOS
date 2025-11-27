import SwiftUI

struct StoreVoucherCardView: View {
    var body: some View {
        EmptyView()
            .modifier(TopLeftTextLayoutStyle(
                title: "스토어 교환권",
                description: nil,
                iconName: "ticket",
                iconSize: 50,
                titleFont: .bold22
            ))
    }
}

#Preview {
    StoreVoucherCardView()
        .padding()
}

