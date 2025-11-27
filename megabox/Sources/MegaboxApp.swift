import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MegaboxApp: App {
    
    init() {
        // Kakao SDK 초기화
        if let appKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String {
            KakaoSDK.initSDK(appKey: appKey)
//            print("Kakao SDK initialized with key: \(appKey)")
        } else {
//            print("Kakao SDK 초기화 실패: 앱 키를 찾을 수 없음")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
