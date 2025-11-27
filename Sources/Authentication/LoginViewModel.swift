// LoginViewModel.swift
// (이 코드로 파일 전체를 덮어쓰세요)

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var loginInfo = LoginModel()
    @Published var isLoggedIn: Bool = false
    @Published var userName: String = "" // 마이페이지 표시용
    

    private let idAccount = "userID"
    private let pwdAccount = "userPassword"
    
    init() {
        checkAutoLogin()
    }

    func checkAutoLogin() {
        guard let savedId = KeychainHelper.read(account: idAccount),
              let savedPwd = KeychainHelper.read(account: pwdAccount) else {
            print("No credentials found in Keychain.")
            return
        }
        
        print("Auto login successful.")
        self.userName = savedId // 마이페이지용 이름 설정 (체크리스트 3번)
        self.isLoggedIn = true // 로그인 상태를 true로 변경
    }

    func handleLogin() {
        let correctId = "swift"
        let correctPwd = "1234"
        
        if loginInfo.id == correctId && loginInfo.pwd == correctPwd {
            let idSaved = KeychainHelper.save(string: loginInfo.id, account: idAccount)
            let pwdSaved = KeychainHelper.save(string: loginInfo.pwd, account: pwdAccount)
            
            if idSaved && pwdSaved {
                print("Credentials saved to Keychain.")
                self.userName = loginInfo.id
                self.isLoggedIn = true
            } else {
                print("Failed to save credentials to Keychain.")
            }
            
        } else {
            print("Login failed: Incorrect ID or PWD.")
        }
    }
    
    func handleLogout() {
        let idDeleted = KeychainHelper.delete(account: idAccount)
        let pwdDeleted = KeychainHelper.delete(account: pwdAccount)
        
        if idDeleted && pwdDeleted {
            print("Credentials deleted from Keychain.")
        } else {
            print("Could not delete credentials from Keychain.")
        }
        
        self.isLoggedIn = false
        self.userName = "" // 저장된 사용자 이름도 지웁니다.
    }
}
