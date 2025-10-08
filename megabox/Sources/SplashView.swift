//
//  SplashView.swift
//  megabox
//
//  Created by 문인성 on 9/24/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.white)
            Image("megaboxLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 95)
        }
    }
}

//import SwiftUI
//
//struct SplashView: View {
//    var body: some View {
//        // GeometryReader를 사용해 화면 크기를 읽어옵니다.
//        GeometryReader { geometry in
//            ZStack {
//                Color.white.ignoresSafeArea()
//                
//                Image("megaboxLogo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: geometry.size.width * 0.6)
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height)
//        }
//    }
//}

struct PreviewWrapper2: View {
    @State private var test = ""
    
    var body: some View {
        TextEditor(text: $test)
            .frame(height: 100)
            .border(Color.gray, width: 1)
    }
}

struct PreviewWrapper_previews2: PreviewProvider {
    static let devices = [ "iPhone 16 Pro Max",
                           "iPhone 11"]

    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            SplashView()
                .previewDevice(PreviewDevice(rawValue: device)) // 프리뷰 디바이스 설정
                .previewDisplayName(device) // 프리뷰 이름 설정
        }
    }
}
