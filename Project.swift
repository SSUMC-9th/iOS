import ProjectDescription

let debugConfig = Configuration.debug(name: "Debug", xcconfig: "mega/Sources/Secret.xcconfig")
let releaseConfig = Configuration.release(name: "Release", xcconfig: "mega/Sources/Secret.xcconfig")

let settings = Settings.settings(
    configurations: [debugConfig, releaseConfig]
)

let project = Project(
    name: "mega",
    targets: [
        .target(
            name: "mega",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.mega",
            
            // 1. infoPlist
            infoPlist: .extendingDefault(
                with: [
                    "TMDB_KEY" : "$(TMDB_KEY)",
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "UIAppFonts": [
                        "Pretendard-Black.otf",
                        "Pretendard-Bold.otf",
                        "Pretendard-ExtraBold.otf",
                        "Pretendard-ExtraLight.otf",
                        "Pretendard-Light.otf",
                        "Pretendard-Medium.otf",
                        "Pretendard-Regular.otf",
                        "Pretendard-SemiBold.otf",
                        "Pretendard-Thin.ttf"
                    ],
                ]
            ),
            
            // 2. sources
            sources: ["mega/Sources/**"],
            
            // 3. resources
            resources: ["mega/Resources/**"],
            
            // 4. dependencies (settings 앞으로 이동)
            dependencies: [
                .external(name: "Alamofire"),
                .external(name: "Kingfisher"),
                .external(name: "Moya"),
                
                // 카카오 SDK
                .external(name: "KakaoSDKCommon"),
                .external(name: "KakaoSDKAuth"),
                .external(name: "KakaoSDKUser"),
            ],
            
            // 5. settings (맨 뒤로 이동)
            settings: settings
        ),
        .target(
            name: "megaTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.megaTests",
            infoPlist: .default,
            sources: ["mega/Tests/**"],
            dependencies: [
                .target(name: "mega")
            ]
        ),
    ]
)