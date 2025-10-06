import SwiftUI

public struct ContentView: View {
    @StateObject private var router = NavigationRouter() // 라우터 인스턴스 생성
    
    public var body: some View {
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
        .environmentObject(router) // Observation 기반 환경 주입
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
