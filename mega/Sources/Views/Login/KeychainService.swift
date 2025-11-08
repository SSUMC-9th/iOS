import Foundation
import Security

enum KCKey {
    static let service = "mega.login"
    static let userID  = "user.id"
    static let userPWD = "user.pwd"
    // 별도의 실명 필드가 없다면 ID를 이름으로 사용
    static let userName = "user.name"
    
    static let kakaoAccess  = "kakao_access_token"
    static let kakaoRefresh = "kakao_refresh_token"
}

final class KeychainService {
    static let shared = KeychainService()
    private init() {}

    @discardableResult
    func save(service: String, account: String, value: String) -> Bool {
        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        // 기존 값 삭제 후 재추가
        SecItemDelete(query as CFDictionary)

        var attributes = query
        attributes[kSecValueData as String] = data

        let status = SecItemAdd(attributes as CFDictionary, nil)
        return status == errSecSuccess
    }

    func read(service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data,
              let value = String(data: data, encoding: .utf8) else { return nil }
        return value
    }

    @discardableResult
    func delete(service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }

    // 편의: 로그인 관련 전체 삭제
    func purgeLogin() {
        _ = delete(service: KCKey.service, account: KCKey.userID)
        _ = delete(service: KCKey.service, account: KCKey.userPWD)
        _ = delete(service: KCKey.service, account: KCKey.userName)
    }
}
