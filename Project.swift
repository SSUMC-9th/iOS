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
