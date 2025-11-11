import ProjectDescription

let debugConfig = Configuration.debug(name: "Debug", xcconfig: "mega/Sources/Secret.xcconfig")
let releaseConfig = Configuration.release(name: "Release", xcconfig: "mega/Sources/Secret.xcconfig")

let settings = Settings.settings(
    configurations: [debugConfig, releaseConfig]
)

let project = Project(
    name: "mega", settings: settings,
    targets: [
        .target(
            name: "mega",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.mega",
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
            dependencies: [
		.target(name: "mega")

		]
        ),
    ]
)
