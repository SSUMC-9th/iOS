//
//  TabView.swift
//  megabox
//
//  Created by 문인성 on 10/8/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("홈" , systemImage: "house.fill") {
                Home()
            }
            
            Tab("바로 예매" , systemImage: "play.laptopcomputer") {
                LoginView(viewModel: LoginViewModel())
            }
            
            Tab("모바일 오더" , systemImage: "popcorn") {
                LoginView(viewModel: LoginViewModel())
            }
            
            Tab("마이 페이지" , systemImage: "person") {
                UserInformation()
                
            }
        }
    }
}

#Preview {
    MainTabView()
}
