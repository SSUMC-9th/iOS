import Foundation
import SwiftUI
import Observation

@Observable
class LoginViewModel {
    var loginModel: LoginModel
    var isLoading: Bool = false   // 로딩 상태 바인딩용

    private let kakaoAuth = KakaoAuthREST()

    init(loginModel: LoginModel) {
        self.loginModel = loginModel
    }

    // 기존 일반 로그인
    func registerToKeychain() -> Bool {
        let ok1 = KeychainService.shared.save(
            service: KCKey.service,
            account: KCKey.userID,
            value: loginModel.id
        )
        let ok2 = KeychainService.shared.save(
            service: KCKey.service,
            account: KCKey.userPWD,
            value: loginModel.pwd
        )
        let ok3 = KeychainService.shared.save(
            service: KCKey.service,
            account: KCKey.userName,
            value: loginModel.id
        )
        return ok1 && ok2 && ok3
    }

    func tryAutoLogin() -> Bool {
        guard let id = KeychainService.shared.read(service: KCKey.service, account: KCKey.userID),
              let _  = KeychainService.shared.read(service: KCKey.service, account: KCKey.userPWD) else {
            return false
        }
        let name = KeychainService.shared.read(service: KCKey.service, account: KCKey.userName) ?? id
        UserSession.shared.displayName = name
        UserSession.shared.isLoggedIn = true
        return true
    }

    // 카카오 로그인
    func loginWithKakaoREST(completion: ((Bool) -> Void)? = nil) {
        isLoading = true
        kakaoAuth.login { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    print("[KakaoREST] 로그인 실패:", error.localizedDescription)
                    completion?(false)

                case .success(let (token, user)):
                    // 토큰을 키체인에 저장
                    _ = KeychainService.shared.save(
                        service: KCKey.service,
                        account: KCKey.kakaoAccess,
                        value: token.access_token
                    )
                    if let r = token.refresh_token {
                        _ = KeychainService.shared.save(
                            service: KCKey.service,
                            account: KCKey.kakaoRefresh,
                            value: r
                        )
                    }

                    // 세션 업데이트
                    let nickname = user.kakao_account?.profile?.nickname
                        ?? KeychainService.shared.read(service: KCKey.service, account: KCKey.userName)
                        ?? self.loginModel.id
                    UserSession.shared.displayName = nickname
                    UserSession.shared.isLoggedIn = true
                    completion?(true)
                }
            }
        }
    }
}
