// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "GoogleMaps",
    products: [
        .library(
            name: "GoogleMaps",
            targets: [
                "GoogleMaps",
                "GoogleMapsBase",
                "GoogleMapsCore"
            ]
        ),
        .library(
            name: "GoogleMapsBase",
            targets: [
                "GoogleMapsBase"
            ]
        ),
        .library(
            name: "GoogleMapsCore",
            targets: [
                "GoogleMapsCore"
            ]
        ),
        .library(
            name: "GoogleMapsM4B",
            targets: [
                "GoogleMapsM4B"
            ]
        )
    ],
    targets: [
        .binaryTarget(
            name: "GoogleMaps",
            path: "XCFrameworks/GoogleMaps.xcframework"
        ),
        .binaryTarget(
            name: "GoogleMapsBase",
            path: "XCFrameworks/GoogleMapsBase.xcframework"
        ),
        .binaryTarget(
            name: "GoogleMapsCore",
            path: "XCFrameworks/GoogleMapsCore.xcframework"
        ),
        .binaryTarget(
            name: "GoogleMapsM4B",
            path: "XCFrameworks/GoogleMapsM4B.xcframework"
        )
    ]
)
