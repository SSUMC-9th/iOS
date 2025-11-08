import Foundation

struct KakaoUser: Decodable {
    struct Account: Decodable {
        struct Profile: Decodable { let nickname: String? }
        let profile: Profile?
    }
    let id: Int64
    let kakao_account: Account?
}
