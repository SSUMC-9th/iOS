import SwiftUI

public struct ContentView: View {
    @State private var router = NavigationRouter() // 라우터 인스턴스 생성
    
    public var body: some View {
        NavigationStack(path: $router.path) {
            HomeView()
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    HomeView()
                case .profile:
                    ProfileView()
                case .mainTab:
                    MainTabView()
                case .login:
                    LoginView(router: router)
                }
            }
            .navigationTitle("Test")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
