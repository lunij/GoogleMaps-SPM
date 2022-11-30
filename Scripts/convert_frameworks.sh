#!/bin/bash

set -euo pipefail

cd $(dirname $0)/..
ROOT_DIR=$PWD
LEGACY_FRAMEWORKS_DIR="$ROOT_DIR/LegacyFrameworks"
PROJECT_FRAMEWORKS_DIR="$ROOT_DIR/GoogleMaps/Frameworks"

function cecho() {
    echo -e "\033[1;36m>>\033[1;37m $1\033[0m"
}

function convert_arm64() {
    local framework_name=$1
    local lc_build_version=`otool -l -arch arm64 "$framework_name.framework/$framework_name" | grep -A 4 -m 1 "cmd LC_BUILD_VERSION"`
    local platform=`echo $lc_build_version | sed -r 's/cmd LC_BUILD_VERSION .* platform ([0-9])+ minos ([0-9]+.[0-9])+ sdk ([0-9]+.[0-9])+/\1/'`
    local minos=`echo $lc_build_version | sed -r 's/cmd LC_BUILD_VERSION .* platform ([0-9])+ minos ([0-9]+.[0-9])+ sdk ([0-9]+.[0-9])+/\2/'`
    local sdk=`echo $lc_build_version | sed -r 's/cmd LC_BUILD_VERSION .* platform ([0-9])+ minos ([0-9]+.[0-9])+ sdk ([0-9]+.[0-9])+/\3/'`

    cecho "platform: $platform"
    cecho "minos: $minos"
    cecho "sdk: $sdk"

    xcrun vtool \
        -arch arm64 \
        -set-build-version 7 $minos $sdk \
        -replace \
        -output iphonesimulator/$framework_name.framework/$framework_name.reworked \
        iphonesimulator/$framework_name.framework/$framework_name

    rm iphonesimulator/$framework_name.framework/$framework_name
    mv iphonesimulator/$framework_name.framework/$framework_name.reworked iphonesimulator/$framework_name.framework/$framework_name

    xcrun codesign --sign - iphonesimulator/$framework_name.framework/$framework_name
}

function convert_framework() {
    local framework_name=$1

    cecho "Converting $framework_name.framework"

    cp -R $framework_name.framework iphoneos/$framework_name.framework
    cp -R $framework_name.framework iphonesimulator/$framework_name.framework

    lipo $framework_name.framework/$framework_name -thin arm64 -output iphoneos/$framework_name.arm64

    lipo $framework_name.framework/$framework_name -thin arm64 -output iphonesimulator/$framework_name.arm64
    lipo $framework_name.framework/$framework_name -thin x86_64 -output iphonesimulator/$framework_name.x86_64

    lipo -create -output iphoneos/$framework_name.framework/$framework_name iphoneos/$framework_name.arm64
    lipo -create -output iphonesimulator/$framework_name.framework/$framework_name iphonesimulator/$framework_name.arm64 iphonesimulator/$framework_name.x86_64

    convert_arm64 $framework_name
}

function convert_frameworks() {
    cd $LEGACY_FRAMEWORKS_DIR

    rm -rf iphoneos
    rm -rf iphonesimulator
    rm -rf $PROJECT_FRAMEWORKS_DIR/iphoneos
    rm -rf $PROJECT_FRAMEWORKS_DIR/iphonesimulator

    mkdir -p iphoneos
    mkdir -p iphonesimulator
    mkdir -p $PROJECT_FRAMEWORKS_DIR/iphoneos
    mkdir -p $PROJECT_FRAMEWORKS_DIR/iphonesimulator

    convert_framework "GoogleMaps"
    convert_framework "GoogleMapsBase"
    convert_framework "GoogleMapsCore"
    convert_framework "GoogleMapsM4B"

    mv iphoneos/*.framework $PROJECT_FRAMEWORKS_DIR/iphoneos/
    mv iphonesimulator/*.framework $PROJECT_FRAMEWORKS_DIR/iphonesimulator/

    ln -sF $PROJECT_FRAMEWORKS_DIR/iphoneos/GoogleMaps.framework $PROJECT_FRAMEWORKS_DIR
    ln -sF $PROJECT_FRAMEWORKS_DIR/iphoneos/GoogleMapsBase.framework $PROJECT_FRAMEWORKS_DIR
    ln -sF $PROJECT_FRAMEWORKS_DIR/iphoneos/GoogleMapsCore.framework $PROJECT_FRAMEWORKS_DIR
    ln -sF $PROJECT_FRAMEWORKS_DIR/iphoneos/GoogleMapsM4B.framework $PROJECT_FRAMEWORKS_DIR
}

convert_frameworks
