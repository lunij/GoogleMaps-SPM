import Foundation
import ProjectDescription

let googleMapsPath = "Frameworks/GoogleMaps.framework"
let googleMapsBasePath = "Frameworks/GoogleMapsBase.framework"
let googleMapsCorePath = "Frameworks/GoogleMapsCore.framework"
let googleMapsM4BPath = "Frameworks/GoogleMapsM4B.framework"

let project = Project(
    name: "GoogleMaps",
    options: .options(
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    targets: [
        Target(
            name: "GoogleMaps",
            platform: .iOS,
            product: .framework,
            bundleId: "com.not-google.GoogleMaps",
            deploymentTarget: .default,
            infoPlist: .file(path: "Info.plist"),
            resources: "\(googleMapsPath)/Resources/**",
            headers: .allHeaders(
                from: "\(googleMapsPath)/Headers/*.h",
                umbrella: "\(googleMapsPath)/Headers/GoogleMaps.h"
            ),
            scripts: [
                .pre(
                    script: """
                    ln -sF $SRCROOT/ModifiedFrameworks/$PLATFORM_NAME/GoogleMaps.framework Frameworks
                    ln -sF $SRCROOT/ModifiedFrameworks/$PLATFORM_NAME/GoogleMapsCore.framework Frameworks
                    """,
                    name: "Symlinks",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .target(name: "GoogleMapsBase"),
                .sdk(name: "c++", type: .library),
                .sdk(name: "z", type: .library),
                .sdk(name: "CoreData", type: .framework),
                .sdk(name: "CoreGraphics", type: .framework),
                .sdk(name: "CoreImage", type: .framework),
                .sdk(name: "CoreLocation", type: .framework),
                .sdk(name: "CoreTelephony", type: .framework),
                .sdk(name: "CoreText", type: .framework),
                .sdk(name: "Foundation", type: .framework),
                .sdk(name: "GLKit", type: .framework),
                .sdk(name: "ImageIO", type: .framework),
                .sdk(name: "Metal", type: .framework),
                .sdk(name: "OpenGLES", type: .framework),
                .sdk(name: "QuartzCore", type: .framework),
                .sdk(name: "SystemConfiguration", type: .framework),
                .sdk(name: "UIKit", type: .framework),
                .library(
                    path: "\(googleMapsPath)/GoogleMaps",
                    publicHeaders: "\(googleMapsPath)/Headers",
                    swiftModuleMap: "\(googleMapsPath)/Modules/module.modulemap"
                ),
                .library(
                    path: "\(googleMapsCorePath)/GoogleMapsCore",
                    publicHeaders: "",
                    swiftModuleMap: "\(googleMapsCorePath)/Modules/module.modulemap"
                )
            ],
            settings: .settings(
                base: .shared.merging([
                    "OTHER_LDFLAGS": "-Objc -L$(SRCROOT)/\(googleMapsPath) -L$(SRCROOT)/\(googleMapsCorePath)",
                    "HEADER_SEARCH_PATHS": "$(SRCROOT)/\(googleMapsPath)/Headers",
                    "LIBRARY_SEARCH_PATHS": "$(SRCROOT)/\(googleMapsPath) $(SRCROOT)/\(googleMapsCorePath)",
                    "MODULEMAP_FILE": "$(SRCROOT)/\(googleMapsPath)/Modules/module.modulemap"
                ])
            )
        ),
        Target(
            name: "GoogleMapsBase",
            platform: .iOS,
            product: .framework,
            bundleId: "com.not-google.GoogleMapsBase",
            deploymentTarget: .default,
            infoPlist: .file(path: "Info.plist"),
            headers: .allHeaders(
                from: "\(googleMapsBasePath)/Headers/*.h",
                umbrella: "\(googleMapsBasePath)/Headers/GoogleMapsBase.h"
            ),
            scripts: [
                .pre(
                    script: "ln -sF $SRCROOT/ModifiedFrameworks/$PLATFORM_NAME/GoogleMapsBase.framework Frameworks",
                    name: "Symlinks",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .sdk(name: "c++", type: .library),
                .sdk(name: "z", type: .library),
                .sdk(name: "CoreGraphics", type: .framework),
                .sdk(name: "CoreLocation", type: .framework),
                .sdk(name: "CoreTelephony", type: .framework),
                .sdk(name: "CoreText", type: .framework),
                .sdk(name: "Foundation", type: .framework),
                .sdk(name: "QuartzCore", type: .framework),
                .sdk(name: "Security", type: .framework),
                .sdk(name: "UIKit", type: .framework),
                .library(
                    path: "\(googleMapsBasePath)/GoogleMapsBase",
                    publicHeaders: "\(googleMapsBasePath)/Headers",
                    swiftModuleMap: "\(googleMapsBasePath)/Modules/module.modulemap"
                )
            ],
            settings: .settings(
                base: .shared.merging([
                    "OTHER_LDFLAGS": "-L$(SRCROOT)/\(googleMapsBasePath)",
                    "HEADER_SEARCH_PATHS": "$(SRCROOT)/\(googleMapsBasePath)/Headers",
                    "LIBRARY_SEARCH_PATHS": "$(SRCROOT)/\(googleMapsBasePath)",
                    "MODULEMAP_FILE": "$(SRCROOT)/\(googleMapsBasePath)/Modules/module.modulemap"
                ])
            )
        ),
        Target(
            name: "GoogleMapsCore",
            platform: .iOS,
            product: .framework,
            bundleId: "com.not-google.GoogleMapsCore",
            deploymentTarget: .default,
            infoPlist: .file(path: "Info.plist"),
            settings: .settings(
                base: .shared.merging([
                    "OTHER_LDFLAGS": "-L$(SRCROOT)/\(googleMapsCorePath)",
                    "LIBRARY_SEARCH_PATHS": "$(SRCROOT)/\(googleMapsCorePath)",
                    "MODULEMAP_FILE": "$(SRCROOT)/\(googleMapsCorePath)/Modules/module.modulemap"
                ])
            )
        ),
        Target(
            name: "GoogleMapsM4B",
            platform: .iOS,
            product: .framework,
            bundleId: "com.not-google.GoogleMapsM4B",
            deploymentTarget: .default,
            infoPlist: .file(path: "Info.plist"),
            headers: .headers(public: "\(googleMapsM4BPath)/Headers/GoogleMaps.h"),
            scripts: [
                .pre(
                    script: "ln -sF $SRCROOT/ModifiedFrameworks/$PLATFORM_NAME/GoogleMapsM4B.framework Frameworks",
                    name: "Symlinks",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .sdk(name: "c++", type: .library),
                .sdk(name: "Foundation", type: .framework),
                .library(
                    path: "\(googleMapsM4BPath)/GoogleMapsM4B",
                    publicHeaders: "\(googleMapsM4BPath)/Headers",
                    swiftModuleMap: "\(googleMapsM4BPath)/Modules/module.modulemap"
                )
            ],
            settings: .settings(
                base: .shared.merging([
                    "OTHER_LDFLAGS": "-L$(SRCROOT)/\(googleMapsM4BPath)",
                    "HEADER_SEARCH_PATHS": "$(SRCROOT)/\(googleMapsM4BPath)/Headers",
                    "LIBRARY_SEARCH_PATHS": "$(SRCROOT)/\(googleMapsM4BPath)",
                    "MODULEMAP_FILE": "$(SRCROOT)/\(googleMapsM4BPath)/Modules/module.modulemap"
                ])
            )
        )
    ]
)

extension DeploymentTarget {
    static var `default`: Self {
        .iOS(targetVersion: "14.0", devices: .iphone)
    }
}

extension SettingsDictionary {
    static var shared: Self {
        [
            "BUILD_LIBRARY_FOR_DISTRIBUTION": true,
            "CURRENT_PROJECT_VERSION": .projectVersion,
            "DEFINES_MODULE": true,
            "DYLIB_INSTALL_NAME_BASE": "@rpath",
            "LD_RUNPATH_SEARCH_PATHS": "$(inherited) @executable_path/Frameworks @loader_path/Frameworks",
            "SKIP_INSTALL": true,
            "MARKETING_VERSION": .marketingVersion,
            "TARGETED_DEVICE_FAMILY": "1,2"
        ]
    }
}

extension SettingValue {
    static var marketingVersion: Self {
        .string(.marketingVersion)
    }

    static var projectVersion: Self {
        .string(.projectVersion)
    }
}

private extension String {
    static var marketingVersion: Self {
        let fileName = ".marketing-version"
        let rootPath = FileManager.default.currentDirectoryPath
        do {
            let value = try String(contentsOfFile: rootPath + "/" + fileName)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            return value
        } catch {
            fatalError("Ensure the file \"\(fileName)\" exists and is readable!")
        }
    }

    static var projectVersion: Self {
        let numbers = String.marketingVersion.split(separator: ".").map(String.init).compactMap(Int.init)
        guard numbers.count == 3 else {
            fatalError("The marketing version needs to conform to the semantic version format <major>.<minor>.<patch>")
        }
        return String(format: "%02d%02d%02d", numbers[0], numbers[1], numbers[2])
    }
}
