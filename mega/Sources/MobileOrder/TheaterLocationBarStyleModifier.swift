//
//  TheaterLocationBarStyleModifier.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//

import Foundation
import SwiftUI

struct TheaterBarStyle {
    let background: Color
    let mainForeground: Color
    let buttonBackground: Color
    let buttonText: Color
    let buttonBorder: Color

    static let purple = TheaterBarStyle(
        background: Color("purple03"),
        mainForeground: .white,
        buttonBackground: .white,
        buttonText: Color("purple03"),
        buttonBorder: .clear
    )

    static let white = TheaterBarStyle(
        background: .white,
        mainForeground: .black,
        buttonBackground: .white,
        buttonText: Color("purple03"),
        buttonBorder: Color("purple03")
    )
}

private struct TheaterBarStyleKey: EnvironmentKey {
    static let defaultValue: TheaterBarStyle = .purple
}

extension EnvironmentValues {
    var theaterBarStyle: TheaterBarStyle {
        get { self[TheaterBarStyleKey.self] }
        set { self[TheaterBarStyleKey.self] = newValue }
    }
}

// ViewModifier – 스타일을 바꿔 끼우는 용도
struct TheaterBarStyleModifier: ViewModifier {
    let style: TheaterBarStyle

    func body(content: Content) -> some View {
        content.environment(\.theaterBarStyle, style)
    }
}

extension View {
    func theaterBarStyle(_ style: TheaterBarStyle) -> some View {
        modifier(TheaterBarStyleModifier(style: style))
    }
}

