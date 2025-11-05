//
//  SplashView.swift
//  megabox
//
//  Created by 문인성 on 9/24/25.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var isSplashFinished: Bool
    
    var body: some View {
        
        ZStack {
            Color(.white)
            Image("megaboxLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 95)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isSplashFinished = true
                }
            }
        }
    }
}

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
            
            SplashView(isSplashFinished: .constant(false))
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
