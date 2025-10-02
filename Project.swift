import ProjectDescription

let project = Project(
    name: "mega",
    targets: [
        .target(
            name: "mega",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.mega",
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
                        "Pretendard-Thin.ttf"
                    ],
                ]
            ),
            buildableFolders: [
                "mega/Sources",
                "mega/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "megaTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.megaTests",
            infoPlist: .default,
            buildableFolders: [
                "mega/Tests"
            ],
            dependencies: [.target(name: "mega")]
        ),
    ]
)
