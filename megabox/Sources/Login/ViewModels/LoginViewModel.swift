//
//  LoginViewModel.swift
//  megabox
//
//  Created by 김세은 on 9/27/25.
//
import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewModel: ObservableObject {
    @Published var loginModel: LoginModel
    @Published var kakaoNickname: String = ""
    
    init(loginModel: LoginModel) {
        self.loginModel = loginModel
    }

    
    // 카카오 로그인 함수
    func loginWithKakao(router: NavigationRouter) {
        if UserApi.isKakaoTalkLoginAvailable() {
            // ✅ 카카오톡 앱이 있을 경우
            UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
                if let error = error {
                    print("KakaoTalk login failed: \(error.localizedDescription)")
                } else {
                    print("KakaoTalk login success")
                    self?.fetchUserInfo(router: router)
                }
            }
        } else {
            // ✅ 카카오 계정 로그인 (웹)
            UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
                if let error = error {
                    print("KakaoAccount login failed: \(error.localizedDescription)")
                } else {
                    print("KakaoAccount login success")
                    self?.fetchUserInfo(router: router)
                }
            }
        }
    }

    private func fetchUserInfo(router: NavigationRouter) {
        UserApi.shared.me { [weak self] user, error in
            if let error = error {
                print("Failed to fetch user info: \(error.localizedDescription)")
                return
            }
            guard let self = self, let user = user else { return }

            self.kakaoNickname = user.kakaoAccount?.profile?.nickname ?? "알 수 없음"
            print("로그인 사용자 닉네임: \(self.kakaoNickname)")

            // Keychain 저장
            KeychainHelper.shared.save(self.kakaoNickname, forKey: "savedName")

            // 홈으로 이동
            router.push(.mainTab)
        }
    }
}
