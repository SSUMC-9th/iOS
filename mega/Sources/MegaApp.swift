import SwiftUI
import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MegaApp: App {
    
    init() {
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
