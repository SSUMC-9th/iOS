//
//  SplashView.swift
//  mega
//
//  Created by 이경민 on 9/19/25.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack(alignment:.center) {
            Color.white
                .edgesIgnoringSafeArea(.all)

            // 메가박스 로고 이미지
            Image("megaboxLogo")
                .resizable()
                .aspectRatio(contentMode: .fit) // 이미지 비율 유지
                .frame(width: 200) // 로고 크기 조절
        }
    }
}

#Preview {
    SplashScreenView()
}
