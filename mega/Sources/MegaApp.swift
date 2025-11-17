import SwiftUI
import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MegaApp: App {
    
    init() {
        print("TMDB bearer length =", TMDBKeys.bearer.count)
        KakaoSDK.initSDK(appKey: KakaoKeys.nativeAppKey)
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
            }
        }
    }
}
