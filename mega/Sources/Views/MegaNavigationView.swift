//
//  MegaNavigation.swift
//  mega
//
//  Created by 이경민 on 9/28/25.
//

import SwiftUI

struct MegaNavigation: View {
    var body: some View {
        homeTab
    }
    
    private var homeTab: some View {
        TabView {
            Tab("홈", systemImage:"house"){
                HomeView()
            }
            Tab("바로예매", systemImage:"video"){
                ReservView()
            }
            Tab("모바일 오더", systemImage: "popcorn"){
                
            }
            Tab("마이 페이지", systemImage: "person"){
                NavigationStack {
                    UserInfo()
                }
            }
        }
    }
}

#Preview {
    MegaNavigation()
}
