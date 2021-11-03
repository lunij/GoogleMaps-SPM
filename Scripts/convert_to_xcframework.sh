#!/bin/zsh

set -euo pipefail

minos=14
tmp_dir="tmp"

rm -rf $tmp_dir

function create_xcframework() {
    name=$1

    mkdir -p $tmp_dir/iphone
    mkdir -p $tmp_dir/simulator

    cp -R Carthage/Build/iOS/$name.framework $tmp_dir/iphone/$name.framework
    cp -R Carthage/Build/iOS/$name.framework $tmp_dir/simulator/$name.framework

    lipo \
        -remove x86_64 \
        -output $tmp_dir/iphone/$name.framework/$name \
        $tmp_dir/iphone/$name.framework/$name

    # Apple Silicon support for dynamic libs - https://bogo.wtf/arm64-to-sim-dylibs.html
    xcrun vtool -arch arm64 \
        -set-build-version 7 $minos 14.0 \
        -replace \
        -output $tmp_dir/simulator/$name.framework/$name.reworked \
        $tmp_dir/simulator/$name.framework/$name

    rm $tmp_dir/simulator/$name.framework/$name
    mv $tmp_dir/simulator/$name.framework/$name.reworked $tmp_dir/simulator/$name.framework/$name

    xcrun codesign --sign - $tmp_dir/simulator/$name.framework/$name

    # Apple Silicon support for static libs - https://github.com/bogo/arm64-to-sim

    xcodebuild -create-xcframework \
        -framework $tmp_dir/iphone/$name.framework \
        -framework $tmp_dir/simulator/$name.framework \
        -output $tmp_dir/$name.xcframework
}

function zip_xcframework() {
    name=$1

    pushd $tmp_dir
    zip -qr $name.xcframework.zip $name.xcframework
    shasum -a 256 "$name.xcframework.zip" >> checksums
    popd

    echo "$tmp_dir/$name.zip created"
}

create_xcframework "GoogleMaps"
create_xcframework "GoogleMapsBase"
create_xcframework "GoogleMapsCore"
create_xcframework "GoogleMapsM4B"
create_xcframework "GooglePlaces"

zip_xcframework "GoogleMaps"
zip_xcframework "GoogleMapsBase"
zip_xcframework "GoogleMapsCore"
zip_xcframework "GoogleMapsM4B"
zip_xcframework "GooglePlaces"
