import ProjectDescription

let project = Project(
    name: "megabox",
    packages: [
            .package(url: "https://github.com/kakao/kakao-ios-sdk", from: "2.20.0"),
            .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0")
        ],
    targets: [
        .target(
            name: "megabox",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.megabox",
            infoPlist: .extendingDefault(
                with: [
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
                        "Pretendard-Thin.otf"
                    ],
                    
                    // Secret.xcconfig 키 사용
                    "KAKAO_NATIVE_APP_KEY": "$(KAKAO_NATIVE_APP_KEY)",

                    // 카카오 로그인용 URL Scheme 등록
                    "CFBundleURLTypes": [
                        [
                            "CFBundleURLSchemes": ["kakao$(KAKAO_NATIVE_APP_KEY)"]
                        ]
                    ],

                    // 카카오 SDK가 외부 앱을 열 수 있게 허용
                    "LSApplicationQueriesSchemes": [
                        "kakaokompassauth",
                        "kakaolink"
                    ]
                ]
            ),
            buildableFolders: [
                "megabox/Sources",
                "megabox/Resources",
            ],
            dependencies: [
                .package(product: "KakaoSDKCommon"),
                .package(product: "KakaoSDKAuth"),
                .package(product: "KakaoSDKUser"),
                .package(product: "Alamofire")
            ],
            
            // xcconfig 연결
            settings: .settings(
                base: [
                    "OTHER_SWIFT_FLAGS": "-DDEBUG"
                ],
                configurations: [
                    // Secret.xcconfig 연결
                    .debug(name: "Debug", xcconfig: "./megabox/Resources/Secret/Secret.xcconfig"),
                    .release(name: "Release", xcconfig: "./megabox/Resources/Secret/Secret.xcconfig")
                ]
            )
        ),
        .target(
            name: "megaboxTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.megaboxTests",
            infoPlist: .default,
            buildableFolders: [
                "megabox/Tests"
            ],
            dependencies: [.target(name: "megabox")]
        ),
    ]
)
