import Foundation
import AuthenticationServices
import Alamofire
import UIKit

final class KakaoAuthREST: NSObject, ASWebAuthenticationPresentationContextProviding {
    private var session: ASWebAuthenticationSession?

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }

    func login(completion: @escaping (Result<(KakaoTokenResponse, KakaoUser), Error>) -> Void) {
        var comps = URLComponents(string: "https://kauth.kakao.com/oauth/authorize")!
        comps.queryItems = [
            .init(name: "response_type", value: "code"),
            .init(name: "client_id", value: KakaoKeys.restApiKey),
            .init(name: "redirect_uri", value: KakaoKeys.redirectURI)
        ]
        let authURL = comps.url!

        session = ASWebAuthenticationSession(
            url: authURL,
            callbackURLScheme: KakaoKeys.redirectScheme
        ) { [weak self] callbackURL, error in
            guard let self else { return }
            if let error { completion(.failure(error)); return }
            guard
                let url = callbackURL,
                let code = URLComponents(url: url, resolvingAgainstBaseURL: false)?
                    .queryItems?.first(where: { $0.name == "code" })?.value
            else {
                completion(.failure(NSError(domain: "Auth", code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "No auth code"]))); return
            }
            self.exchangeToken(with: code, completion: completion)
        }
        session?.presentationContextProvider = self
        _ = session?.start()
    }

    private func exchangeToken(with code: String,
                               completion: @escaping (Result<(KakaoTokenResponse, KakaoUser), Error>) -> Void) {
        let tokenURL = "https://kauth.kakao.com/oauth/token"
        let params: [String: String] = [
            "grant_type": "authorization_code",
            "client_id": KakaoKeys.restApiKey,
            "redirect_uri": KakaoKeys.redirectURI,
            "code": code
        ]
        AF.request(tokenURL,
                   method: .post,
                   parameters: params,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: ["Content-Type":"application/x-www-form-urlencoded;charset=utf-8"])
        .validate()
        .responseDecodable(of: KakaoTokenResponse.self) { resp in
            switch resp.result {
            case .failure(let err):
                completion(.failure(err))
            case .success(let token):
                let meURL = "https://kapi.kakao.com/v2/user/me"
                let headers: HTTPHeaders = ["Authorization": "Bearer \(token.access_token)"]
                AF.request(meURL, method: .get, headers: headers)
                    .validate()
                    .responseDecodable(of: KakaoUser.self) { me in
                        switch me.result {
                        case .failure(let err): completion(.failure(err))
                        case .success(let user): completion(.success((token, user)))
                        }
                    }
            }
        }
    }
}
