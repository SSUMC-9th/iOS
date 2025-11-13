import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewModel: ObservableObject {
    @Published var loginModel: LoginModel
    private let kakaoManager = KaKaoServiceManager.shared
    
    
    init(loginModel: LoginModel) {
        self.loginModel = loginModel
    }

    // MARK: - 카카오 로그인 시작
    func loginWithKakao(router: NavigationRouter) {
        kakaoManager.requestKakaoAuthCode()
    }
    
    // MARK: - 인증 후 AccessToken 처리 (onOpenURL에서 호출)
    func handleKakaoAuthCallback(url: URL, router: NavigationRouter) {
        if let code = extractAuthCode(from: url) {
            kakaoManager.requestAccessToken(authCode: code) { token in
                if let token = token {
                    self.kakaoManager.requestUserInfo(accessToken: token, router: router)
                }
            }
        }
    }
    
    private func extractAuthCode(from url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else { return nil }
        return queryItems.first(where: { $0.name == "code" })?.value
    }
}
