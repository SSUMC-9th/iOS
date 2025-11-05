import Security
import Foundation

final class KeychainHelper {
    static let shared = KeychainHelper()

    private init() {}

    func save(_ value: String, forKey key: String) {
        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        // 기존 값 삭제 후 새 값 추가
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    func read(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        if let data = result as? Data {
            return String(decoding: data, as: UTF8.self)
        }
        return nil
    }
    
    /// Keychain에서 지정된 계정과 서비스에 해당하는 항목을 삭제합니다.
   /// - Parameters:
   ///   - account: 계정 식별자 (예: 사용자 이메일)
   ///   - service: 서비스 이름 (예: "com.example.myapp")
   /// - Returns: Keychain 삭제 작업의 상태 코드 (`errSecSuccess` 등)
   @discardableResult
   func delete(account: String) -> OSStatus {
       // 1. 삭제할 항목을 식별할 쿼리 구성
       let query: [String: Any] = [
           kSecClass as String: kSecClassGenericPassword,   // 삭제 대상 유형
           kSecAttrAccount as String: account,              // 계정 식별자
           kSecAttrService as String: "dev.tuist.megabox"               // 서비스 구분자
       ]

       // 2. 항목 삭제 시도
       let status = SecItemDelete(query as CFDictionary)

       // 3. 상태 확인 및 그 출력
       if status == errSecSuccess {
           print("Keychain 삭제 성공 - [\(kSecAttrService) : \(account)]")
       } else if status == errSecItemNotFound {
           print("Keychain 항목 없음 - [\(kSecAttrService) : \(account)]")
       } else {
           print("Keychain 삭제 실패 - status: \(status)")
       }

       return status
   }
}
