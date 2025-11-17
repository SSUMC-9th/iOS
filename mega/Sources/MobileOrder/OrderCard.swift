//
//  OrderCard.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//

import SwiftUI

struct OrderCard<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                )


            content()
                .padding(20)
        }
    }
}

