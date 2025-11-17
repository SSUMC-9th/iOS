//
//  TheaterLocationBar.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//
import SwiftUI

struct TheaterLocationBar: View {
    let theaterName: String
    var onChangeTap: () -> Void = {}

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image("map-pin")
                    .foregroundStyle(.white)
                Text(theaterName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
            }

            Spacer()

            Button(action: onChangeTap) {
                Text("극장 변경")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color("purple03"))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white)
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .frame(maxWidth: .infinity)
        .background(Color("purple03"))
    }
}

#Preview {
    TheaterLocationBar(theaterName: "강남")
}
