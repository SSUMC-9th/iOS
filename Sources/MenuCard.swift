import SwiftUI

struct MenuCard: View {
    let item: MenuItemModel
    
    @Environment(\.menuCardAction) private var action
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    categoryLabel
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.name)
                            .font(.title3.bold())
                        
                        Text(item.summary)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    
                    infoRow
                    
                    if !item.highlights.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(highlightRows.indices, id: \.self) { index in
                                HStack(spacing: 8) {
                                    ForEach(highlightRows[index]) { highlight in
                                        HighlightTagView(highlight: highlight, accentColor: item.category.accentColor)
                                    }
                                    Spacer(minLength: 0)
                                }
                            }
                        }
                    }
                }
                
                MenuItemImageView(imageName: item.heroImageName, accentColor: item.category.accentColor)
            }
            
            Divider()
            
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(item.formattedPrice)원")
                        .font(.title3.bold())
                        .foregroundStyle(Color.primary)
                    
                    Text(item.memberBenefit)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                
                Spacer(minLength: 16)
                
                Button {
                    action(item)
                } label: {
                    Text(item.isSoldOut ? "품절" : "바로 주문")
                        .font(.headline)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 14)
                        .frame(minWidth: 140)
                        .background(
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .fill(item.isSoldOut ? Color.gray.opacity(0.3) : Color.black)
                        )
                        .foregroundStyle(item.isSoldOut ? Color.white.opacity(0.8) : Color.white)
                }
                .disabled(item.isSoldOut)
                .opacity(item.isSoldOut ? 0.7 : 1)
                .animation(.easeInOut(duration: 0.2), value: item.isSoldOut)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 22, x: 0, y: 12)
        .bestBadge(item.isBest)
        .recommendedBadge(item.isRecommended)
        .discountBadge(item.discountRate)
        .soldOutOverlay(item.isSoldOut)
    }
    
    private var infoRow: some View {
        HStack(spacing: 12) {
            Label(item.waitingTimeText, systemImage: "clock")
            Label(item.pickupInfoText, systemImage: "mappin.and.ellipse")
            
            if let calories = item.calories {
                Label("\(calories) kcal", systemImage: "flame")
            }
        }
        .font(.caption)
        .foregroundStyle(.secondary)
        .labelStyle(.titleAndIcon)
    }
    
    private var highlightRows: [[MenuItemModel.Highlight]] {
        let chunks = stride(from: 0, to: item.highlights.count, by: 2).map { index -> [MenuItemModel.Highlight] in
            let upperBound = min(index + 2, item.highlights.count)
            return Array(item.highlights[index..<upperBound])
        }
        return chunks
    }
    
    private var categoryLabel: some View {
        HStack(spacing: 8) {
            Text(item.category.emoji)
                .font(.system(size: 18))
            Text(item.category.rawValue)
                .font(.footnote.bold())
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(item.category.accentColor.opacity(0.12))
                .foregroundStyle(item.category.accentColor)
                .clipShape(Capsule())
        }
    }
}

private struct HighlightTagView: View {
    let highlight: MenuItemModel.Highlight
    let accentColor: Color
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: highlight.icon)
                .font(.caption.bold())
            Text(highlight.text)
                .font(.caption)
        }
        .foregroundStyle(accentColor)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(accentColor.opacity(0.08))
        .clipShape(Capsule())
    }
}

private struct MenuItemImageView: View {
    let imageName: String?
    let accentColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(accentColor.opacity(0.08))
            
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(accentColor.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [6]))
            
            if let imageName, !imageName.isEmpty {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .padding(8)
            } else {
                VStack(spacing: 6) {
                    Image(systemName: "photo")
                        .font(.system(size: 28, weight: .semibold))
                    Text("이미지를\n추가해주세요")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }
                .foregroundStyle(accentColor)
            }
        }
        .frame(width: 128, height: 128)
    }
}

// MARK: - Environment Action

private struct MenuCardActionKey: EnvironmentKey {
    static let defaultValue: (MenuItemModel) -> Void = { _ in }
}

extension EnvironmentValues {
    var menuCardAction: (MenuItemModel) -> Void {
        get { self[MenuCardActionKey.self] }
        set { self[MenuCardActionKey.self] = newValue }
    }
}

struct MenuCardActionModifier: ViewModifier {
    var action: (MenuItemModel) -> Void
    
    func body(content: Content) -> some View {
        content.environment(\.menuCardAction, action)
    }
}

extension View {
    func onMenuCardOrder(_ action: @escaping (MenuItemModel) -> Void) -> some View {
        modifier(MenuCardActionModifier(action: action))
    }
}

