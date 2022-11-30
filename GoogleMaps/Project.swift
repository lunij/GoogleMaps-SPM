import Foundation
import ProjectDescription

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
            resources: "Frameworks/iphoneos/GoogleMaps.framework/resources/**",
            headers: .allHeaders(
                from: "Frameworks/iphoneos/GoogleMaps.framework/Headers/*.h",
                umbrella: "Frameworks/iphoneos/GoogleMaps.framework/Headers/GoogleMaps.h"
            ),
            scripts: [
                .pre(
                    script: """
                    ln -sF $SRCROOT/Frameworks/$PLATFORM_NAME/GoogleMaps.framework Frameworks
                    ln -sF $SRCROOT/Frameworks/$PLATFORM_NAME/GoogleMapsCore.framework Frameworks
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
                    path: "Frameworks/GoogleMaps.framework/GoogleMaps",
                    publicHeaders: "Frameworks/GoogleMaps.framework/Headers",
                    swiftModuleMap: "Frameworks/GoogleMaps.framework/Modules/module.modulemap"
                ),
                .library(
                    path: "Frameworks/GoogleMapsCore.framework/GoogleMapsCore",
                    publicHeaders: "",
                    swiftModuleMap: "Frameworks/GoogleMapsCore.framework/Modules/module.modulemap"
                )
            ],
            settings: .settings(
                base: .shared.merging([
                    "OTHER_LDFLAGS": "-Objc -L$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMaps.framework -L$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsCore.framework",
                    "HEADER_SEARCH_PATHS": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMaps.framework/Headers",
                    "LIBRARY_SEARCH_PATHS": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMaps.framework $(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsCore.framework",
                    "MODULEMAP_FILE": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMaps.framework/Modules/module.modulemap"
                ]),
                defaultSettings: .none
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
                from: "Frameworks/iphoneos/GoogleMapsBase.framework/Headers/*.h",
                umbrella: "Frameworks/iphoneos/GoogleMapsBase.framework/Headers/GoogleMapsBase.h"
            ),
            scripts: [
                .pre(
                    script: "ln -sF $SRCROOT/Frameworks/$PLATFORM_NAME/GoogleMapsBase.framework Frameworks",
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
                    path: "Frameworks/GoogleMapsBase.framework/GoogleMapsBase",
                    publicHeaders: "Frameworks/GoogleMapsBase.framework/Headers",
                    swiftModuleMap: "Frameworks/GoogleMapsBase.framework/Modules/module.modulemap"
                )
            ],
            settings: .settings(
                base: .shared.merging([
                    "OTHER_LDFLAGS": "-L$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsBase.framework",
                    "HEADER_SEARCH_PATHS": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsBase.framework/Headers",
                    "LIBRARY_SEARCH_PATHS": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsBase.framework",
                    "MODULEMAP_FILE": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsBase.framework/Modules/module.modulemap"
                ]),
                defaultSettings: .none
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
                    "OTHER_LDFLAGS": "-L$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsCore.framework",
                    "LIBRARY_SEARCH_PATHS": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsCore.framework",
                    "MODULEMAP_FILE": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsCore.framework/Modules/module.modulemap"
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
            headers: .headers(public: "Frameworks/iphoneos/GoogleMapsM4B.framework/Headers/GoogleMaps.h"),
            scripts: [
                .pre(
                    script: "ln -sF $SRCROOT/Frameworks/$PLATFORM_NAME/GoogleMapsM4B.framework Frameworks",
                    name: "Symlinks",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .sdk(name: "c++", type: .library),
                .sdk(name: "Foundation", type: .framework),
                .library(
                    path: "Frameworks/GoogleMapsM4B.framework/GoogleMapsM4B",
                    publicHeaders: "Frameworks/GoogleMapsM4B.framework/Headers",
                    swiftModuleMap: "Frameworks/GoogleMapsM4B.framework/Modules/module.modulemap"
                )
            ],
            settings: .settings(
                base: .shared.merging([
                    "OTHER_LDFLAGS": "-L$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsM4B.framework",
                    "HEADER_SEARCH_PATHS": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsM4B.framework/Headers",
                    "LIBRARY_SEARCH_PATHS": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsM4B.framework",
                    "MODULEMAP_FILE": "$(SRCROOT)/Frameworks/$(PLATFORM_NAME)/GoogleMapsM4B.framework/Modules/module.modulemap"
                ]),
                defaultSettings: .none
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
