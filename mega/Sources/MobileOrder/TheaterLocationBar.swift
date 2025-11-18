//
//  TheaterLocationBar.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//
import SwiftUI

struct TheaterLocationBar: View {
    @Environment(\.theaterBarStyle) private var style

    let theaterName: String
    var onChangeTap: () -> Void = {}

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image("map-pin")
                    .renderingMode(.template)
                    .foregroundStyle(style.mainForeground)

                Text(theaterName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(style.mainForeground)
            }

            Spacer()

            Button(action: onChangeTap) {
                Text("극장 변경")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(style.buttonText)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(style.buttonBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(style.buttonBorder, lineWidth: 1)
                    )
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .frame(maxWidth: .infinity)
        .background(style.background)
    }
}


#Preview {
    TheaterLocationBar(theaterName: "강남")
}
