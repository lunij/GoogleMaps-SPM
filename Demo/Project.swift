import ProjectDescription

let project = Project(
    name: "Demo",
    packages: [
        .local(path: "..")
    ],
    targets: [
        Target(
            name: "Demo",
            platform: .iOS,
            product: .app,
            bundleId: "com.not-google.Demo",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "GoogleMaps")
            ]
        )
    ]
)
