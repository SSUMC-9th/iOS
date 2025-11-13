import Foundation
import Alamofire
import SwiftUI

final class KaKaoServiceManager : ObservableObject {
    
    static let shared = KaKaoServiceManager()
    
    @Published var kakaoNickname: String = ""
    @Published var isLoggedIn: Bool = false
    
    private let session: Session
    //kakao 인가코드 url (GET)
    private let authKaKaoUrl = "https://kauth.kakao.com/oauth/authorize";
    //kakao 토큰발급 요청 url  (POST)
    private let tokenKaKaoUrl = "https://kauth.kakao.com/oauth/token";
    //kakao 유저 정보 요청
    private let userInfoKaKaoUrl = "https://kapi.kakao.com/v2/user/me";
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - 카카오 로그인 시작 (웹 인증 GET 요청)
    func requestKakaoAuthCode() {
        let appKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String ?? ""
        let redirectURI = "kakao\(appKey)://oauth"
        let authURL = "\(authKaKaoUrl)?client_id=\(appKey)&redirect_uri=\(redirectURI)&response_type=code"

        if let url = URL(string: authURL) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - 인증 코드 → Access Token 요청
    func requestAccessToken(authCode: String, completion: @escaping (String?) -> Void) {
            let appKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String ?? ""
            let redirectURI = "kakao\(appKey)://oauth"
            let url = "\(tokenKaKaoUrl)"

            let parameters: [String: String] = [
                "grant_type": "authorization_code",
                "client_id": appKey,
                "redirect_uri": redirectURI,
                "code": authCode
            ]
            AF.request(url, method: .post, parameters: parameters)
                .responseDecodable(of: KakaoTokenResponse.self) { response in
                    switch response.result {
                    case .success(let token):
                        print("Access Token: \(token.access_token)")
                        completion(token.access_token)
                    case .failure(let error):
                        print("Token Error: \(error.localizedDescription)")
                        completion(nil)
                    }
                }

    }
    
    // MARK: - 사용자 정보 요청
    func requestUserInfo(accessToken: String, router: NavigationRouter) {
        let url = "\(userInfoKaKaoUrl)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/x-www-form-urlencoded;charset=utf-8"
        ]


        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: KakaoUserResponse.self) { response in
                switch response.result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.kakaoNickname = user.kakao_account?.profile?.nickname ?? "비회원"
                        print("Kakao User: \(self.kakaoNickname)")

                        KeychainHelper.shared.save(self.kakaoNickname, forKey: "savedName")
                        self.isLoggedIn = true
                        router.push(.mainTab)
                    }

                case .failure(let error):
                    print("User Info Error: \(error.localizedDescription)")
                }
            }

    }
}

