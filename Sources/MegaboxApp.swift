import SwiftUI

@main
struct YourApp: App {
    
    @StateObject private var viewModel = LoginViewModel()
    
    @State private var isSplashFinished: Bool = false
    
    var body: some Scene {
        WindowGroup {
            
            if !isSplashFinished {
                SplashView(isSplashFinished: $isSplashFinished)
                
            } else {
                
                if viewModel.isLoggedIn {
                    MainTabView()
                                .environmentObject(viewModel)
                } else {
                    // (checkAutoLogin()이 실패했다면)
                    LoginView(viewModel: viewModel)
                }
            }
        }
    }
}
