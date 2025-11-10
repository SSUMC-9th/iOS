import Foundation

enum KakaoKeys {
    static let nativeAppKey: String =
        Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String ?? ""

    static let restApiKey: String =
        Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY") as? String ?? ""

    static var redirectScheme: String { "kakao\(nativeAppKey)" }
    static var redirectURI: String { "\(redirectScheme)://oauth" }
}

enum TMDBKeys {
    static let bearer: String =
        Bundle.main.object(forInfoDictionaryKey: "TMDB_KEY") as? String ?? ""
}

