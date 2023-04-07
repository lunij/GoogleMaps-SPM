.PHONY: frameworks
frameworks:
	Scripts/convert_frameworks.sh

.PHONY: xcframeworks
xcframeworks:
	Scripts/make_xcframeworks.sh

edit:
	tuist edit --permanent
	open Manifests.xcworkspace

generate:
	tuist generate --no-open

open:
	tuist generate

clean:
	tuist clean
	rm -rf *.xcodeproj
	rm -rf *.xcworkspace
	rm -rf **/*.xcodeproj
	rm -rf .build
	rm -rf Demo/Derived
	rm -rf GoogleMaps/Frameworks/*.framework
	rm -rf GoogleMaps/ModifiedFrameworks/iphoneos
	rm -rf GoogleMaps/ModifiedFrameworks/iphonesimulator
