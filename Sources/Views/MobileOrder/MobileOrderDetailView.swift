import SwiftUI

struct MobileOrderDetailView: View {
    let item: MenuItemModel
    
    @Environment(\.dismiss) private var dismiss
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    
    private var displayItems: [MenuItemModel] {
        var list = MenuItemModel.detailPageItems
        if let matched = list.first(where: { $0.name == item.name }),
           let index = list.firstIndex(of: matched) {
            list.remove(at: index)
            list.insert(matched, at: 0)
        }
        return list
    }
    
    var body: some View {
        VStack(spacing: 0) {
            topBar
            
            Divider()
                .background(Color(.systemGray5))
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    TheaterChangeBar(
                        currentTheater: "강남",
                        subTitle: "",
                        actionTitle: "극장 변경",
                        action: { }
                    )
                    .theaterChangeBarTheme(.outline)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(displayItems) { gridItem in
                            MenuGridCard(item: gridItem)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 28)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
    
    private var topBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3.bold())
                    .foregroundStyle(.black)
                    .padding(10)
            }
            
            Spacer()
            
            Text("바로주문")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Button {
                // cart action placeholder
            } label: {
                Image(systemName: "cart")
                    .font(.title3)
                    .foregroundStyle(.black)
                    .padding(10)
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(Color.white)
    }
}

private struct MenuGridCard: View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topLeading) {
                MenuItemPreviewImage(
                    imageName: item.heroImageName,
                    cornerRadius: 16,
                    height: 190
                )
                
                statusBadge(for: item)
                    .padding(10)
                
                if item.isSoldOut {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.black.opacity(0.55))
                        .overlay(
                            Text("품절")
                                .font(.headline)
                                .foregroundStyle(.white)
                        )
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.system(size: 13))
                    .foregroundStyle(.black)
                    .lineLimit(2)
                
                HStack(spacing: 6) {
                    Text("\(item.formattedPrice)원")
                        .font(.system(size: 14, weight: .semibold))
                    
                    if let origin = item.originalPrice {
                        Text("\(origin.formattedWithComma)원")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.gray)
                            .strikethrough()
                    }
                }
            }
        }
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
    NavigationStack {
        MobileOrderDetailView(item: MenuItemModel.sampleItems.first!)
    }
}

