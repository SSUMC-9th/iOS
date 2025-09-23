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
