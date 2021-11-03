update:
	carthage update

xcframework:
	Scripts/convert_to_xcframework.sh

clean:
	rm -rf Carthage/
	rm -rf tmp/
