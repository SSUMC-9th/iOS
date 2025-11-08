import Foundation

struct KakaoTokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let refresh_token: String?
    let expires_in: Int
    let scope: String?
    let refresh_token_expires_in: Int?
}
