import Foundation

// MARK: - 토큰 응답 DTO
struct KakaoTokenResponse: Codable {
    let access_token: String
    let token_type: String
    let refresh_token: String?
    let expires_in: Int
    let scope: String?
    let refresh_token_expires_in: Int?
}

// MARK: - 유저 정보 응답 DTO
struct KakaoUserResponse: Codable {
    let id: Int
    let connected_at: String?
    let kakao_account: KakaoAccount?
}

struct KakaoAccount: Codable {
    let profile: KakaoProfile?
}

struct KakaoProfile: Codable {
    let nickname: String?
    let thumbnail_image_url: String?
    let profile_image_url: String?
}
