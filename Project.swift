import ProjectDescription

let project = Project(
    name: "megabox",
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
                    ]
                ]
            ),
            buildableFolders: [
                "megabox/Sources",
                "megabox/Resources",
            ],
            dependencies: []
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
