import SwiftUI

struct TheaterChangeBar: View {
    var currentTheater: String
    var subTitle: String
    var actionTitle: String = "극장 변경"
    var action: () -> Void
    
    @Environment(\.theaterChangeBarTheme) private var theme
    
    var body: some View {
        HStack(spacing: 16) {
            if theme.isCompact {
                HStack(spacing: 10) {
                    if let icon = theme.iconSystemName {
                        Image(systemName: icon)
                            .font(.headline)
                            .foregroundStyle(theme.primaryText)
                    }
                    Text(currentTheater)
                        .font(.headline)
                        .foregroundStyle(theme.primaryText)
                }
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text("현재 선택한 극장")
                        .font(.caption)
                        .foregroundStyle(theme.secondaryText)
                    Text(currentTheater)
                        .font(.title3.bold())
                        .foregroundStyle(theme.primaryText)
                    if !subTitle.isEmpty {
                        Text(subTitle)
                            .font(.footnote)
                            .foregroundStyle(theme.secondaryText)
                    }
                }
            }
            
            Spacer()
            
            Button(actionTitle) {
                action()
            }
            .font(.headline)
            .padding(.horizontal, theme.isCompact ? 12 : 16)
            .padding(.vertical, theme.isCompact ? 8 : 10)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(theme.buttonBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(theme.isCompact ? theme.buttonForeground : .clear, lineWidth: theme.isCompact ? 1 : 0)
            )
            .foregroundStyle(theme.buttonForeground)
        }
        .padding(theme.isCompact ? 16 : 20)
        .background(
            RoundedRectangle(cornerRadius: theme.isCompact ? 12 : 28, style: .continuous)
                .fill(theme.background)
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.isCompact ? 12 : 28, style: .continuous)
                .stroke(theme.border.opacity(0.12), lineWidth: 1)
        )
    }
}

// MARK: - Theme

struct TheaterChangeBarTheme {
    let background: Color
    let primaryText: Color
    let secondaryText: Color
    let buttonBackground: Color
    let buttonForeground: Color
    let border: Color
    let isCompact: Bool
    let iconSystemName: String?
    
    static let mobileOrder = TheaterChangeBarTheme(
        background: Color.white,
        primaryText: Color.black,
        secondaryText: Color.gray,
        buttonBackground: Color.black,
        buttonForeground: Color.white,
        border: Color.black,
        isCompact: false,
        iconSystemName: nil
    )
    
    static let detail = TheaterChangeBarTheme(
        background: Color(red: 0.11, green: 0.12, blue: 0.15),
        primaryText: Color.white,
        secondaryText: Color.white.opacity(0.8),
        buttonBackground: Color.white,
        buttonForeground: Color.black,
        border: Color.white,
        isCompact: false,
        iconSystemName: nil
    )
    
    static let highlight = TheaterChangeBarTheme(
        background: Color(red: 0.4, green: 0.05, blue: 0.82),
        primaryText: Color.white,
        secondaryText: Color.white.opacity(0.8),
        buttonBackground: Color.clear,
        buttonForeground: Color.white,
        border: Color.white,
        isCompact: true,
        iconSystemName: "mappin.and.ellipse"
    )
    
    static let outline = TheaterChangeBarTheme(
        background: Color.white,
        primaryText: Color.black,
        secondaryText: Color.gray,
        buttonBackground: Color.clear,
        buttonForeground: Color(red: 0.4, green: 0.05, blue: 0.82),
        border: Color(red: 0.4, green: 0.05, blue: 0.82),
        isCompact: true,
        iconSystemName: "mappin.and.ellipse"
    )
}

private struct TheaterChangeBarThemeKey: EnvironmentKey {
    static let defaultValue: TheaterChangeBarTheme = .mobileOrder
}

extension EnvironmentValues {
    var theaterChangeBarTheme: TheaterChangeBarTheme {
        get { self[TheaterChangeBarThemeKey.self] }
        set { self[TheaterChangeBarThemeKey.self] = newValue }
    }
}

struct TheaterChangeBarThemeModifier: ViewModifier {
    var theme: TheaterChangeBarTheme
    
    func body(content: Content) -> some View {
        content.environment(\.theaterChangeBarTheme, theme)
    }
}

extension View {
    func theaterChangeBarTheme(_ theme: TheaterChangeBarTheme) -> some View {
        modifier(TheaterChangeBarThemeModifier(theme: theme))
    }
}

