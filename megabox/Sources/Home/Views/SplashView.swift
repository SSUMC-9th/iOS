//
//  SplashView.swift
//  megabox
//
//  Created by 김세은 on 9/23/25.
//
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()   // 안전 영역(노치, 홈바 영역)까지 채우기
            Image(.meboxLogo1)
                .resizable()
                .frame(width: 249, height: 84)
        }
        .background(Color.white)
    }
}

#Preview {
    SplashView()
}
