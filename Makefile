.PHONY: xcframeworks
xcframeworks:
	Scripts/make_xcframework.sh

.PHONY: frameworks
frameworks:
	Scripts/convert_frameworks.sh

edit:
	tuist edit --permanent
	open Manifests.xcworkspace

generate:
	tuist generate --no-open

open:
	tuist generate

clean:
	rm -rf .build/
	rm -rf tmp/
	rm -rf *.xcodeproj
	rm -rf *.xcworkspace
