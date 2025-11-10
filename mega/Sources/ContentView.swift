//
//  ContentView.swift
//  mega
//
//  Created by 이경민 on 9/28/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var session = UserSession.shared
    @State private var isLoggedIn: Bool = false

    var body: some View {
        Group {
            if isLoggedIn {
                MegaNavigation()
                    .environmentObject(session)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
                    .environmentObject(session)
            }
        }
        .onAppear(perform: autoLoginIfPossible)
    }

    /// 키체인에 자격증명이 있으면 세션 구성 후 바로 홈으로
    private func autoLoginIfPossible() {
        guard let id  = KeychainService.shared.read(service: KCKey.service, account: KCKey.userID),
              let _   = KeychainService.shared.read(service: KCKey.service, account: KCKey.userPWD) else {
            // 저장된 자격증명이 없으면 로그인 화면 유지
            session.isLoggedIn = false
            isLoggedIn = false
            return
        }
        let name = KeychainService.shared.read(service: KCKey.service, account: KCKey.userName) ?? id
        session.displayName = name
        session.isLoggedIn = true
        isLoggedIn = true
    }
}


