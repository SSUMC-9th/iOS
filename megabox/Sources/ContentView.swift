import SwiftUI

public struct ContentView: View {
    @StateObject private var router = NavigationRouter() // 라우터 인스턴스 생성
    @State private var isLoggedIn = false  // 로그인 상태 추적
    
    public var body: some View {
        Group {
            if isLoggedIn {
                // 로그인된 상태면 메인 탭
                NavigationStack(path: $router.path) {
                    MainTabView()
                        .navigationDestination(for: Route.self) { route in
                            switch route {
                            case .home:
                                HomeView()
                            case .profile:
                                ProfileView()
                            case .memberInfo:
                                MemberInfoView()
                            case .mainTab:
                                MainTabView()
                            case .login:
                                LoginView()
                            }
                        }
                }
                .environmentObject(router)
            } else {
                // 로그인 안 되어 있으면 로그인 화면
                LoginView()
                    .environmentObject(router)
            }
        }
        .onAppear {
            // Keychain에서 로그인 정보 확인
            if let id = KeychainHelper.shared.read(forKey: "savedId"), !id.isEmpty {
                print("로그인 유지: \(id)")
                isLoggedIn = true
            } else {
                print("로그인 필요")
                isLoggedIn = false
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
