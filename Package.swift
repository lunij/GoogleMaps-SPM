// swift-tools-version:5.3
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
            url: "https://github.com/lunij/GoogleMaps-SPM/releases/download/5.1.0/GoogleMaps.xcframework.zip",
            checksum: "f133cf77b596d2f4c5b1e250ebe303d6d7473dc97c2a5df9ea90c13925b99db2"
        ),
        .binaryTarget(
            name: "GoogleMapsBase",
            url: "https://github.com/lunij/GoogleMaps-SPM/releases/download/5.1.0/GoogleMapsBase.xcframework.zip",
            checksum: "0eb70df4a945d643fee81ee23852ef17025caaf7f0631bfc9ac2e01a25756c37"
        ),
        .binaryTarget(
            name: "GoogleMapsCore",
            url: "https://github.com/lunij/GoogleMaps-SPM/releases/download/5.1.0/GoogleMapsCore.xcframework.zip",
            checksum: "8c67400dced7b0eb38692aa39df901a99301455a679a270b0f5a0e2e495b8b7d"
        ),
        .binaryTarget(
            name: "GoogleMapsM4B",
            url: "https://github.com/lunij/GoogleMaps-SPM/releases/download/5.1.0/GoogleMapsM4B.xcframework.zip",
            checksum: "0093fd2c8cfc3c91ecc7804bbf78d026e56fed19be88125caeb902ae95c22b63"
        )
    ]
)
