//
//  Home2.swift
//  megabox
//
//  Created by 문인성 on 10/1/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Tab("홈" , systemImage: "house.fill") {
                LoginView()
            }
            
            Tab("바로 예매" , systemImage: "play.laptopcomputer") {
                LoginView()
            }
            
            Tab("모바일 오더" , systemImage: "popcorn") {
                LoginView()
            }
            
            Tab("마이 페이지" , systemImage: "person") {
                UserInformation()
                
            }
        }
    }
}

#Preview {
    Home()
}
