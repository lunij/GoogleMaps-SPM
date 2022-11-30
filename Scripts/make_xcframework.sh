#!/bin/bash

set -euo pipefail

cd $(dirname $0)/..
ROOT_DIR=$PWD
BUILD_DIR="$ROOT_DIR/.build"
SCRIPTS_DIR="$ROOT_DIR/Scripts"
LEGACY_FRAMEWORKS_DIR="$ROOT_DIR/LegacyFrameworks"
PROJECT_NAME="GoogleMaps"
PROJECT_DIR="$ROOT_DIR/$PROJECT_NAME"

source $SCRIPTS_DIR/convert_frameworks.sh

function cecho() {
    echo -e "\033[1;36m>>\033[1;37m $1\033[0m"
}

function archive_project() {
    local framework_name=$1

    cecho "Archiving $framework_name"

    xcodebuild archive \
        -workspace "../$PROJECT_NAME.xcworkspace" \
        -scheme "$framework_name" \
        -configuration "Release" \
        -destination "generic/platform=iOS" \
        -archivePath "$framework_name.framework-iphoneos.xcarchive" \
        SKIP_INSTALL=NO \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        | xcbeautify

    xcodebuild archive \
        -workspace "../$PROJECT_NAME.xcworkspace" \
        -scheme "$framework_name" \
        -configuration "Simulator Release" \
        -destination "generic/platform=iOS Simulator" \
        -archivePath "$framework_name.framework-iphonesimulator.xcarchive" \
        SKIP_INSTALL=NO \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        | xcbeautify
}

function create_xcframework() {
    local framework_name=$1

    cecho "Creating $framework_name.xcframework"

    xcodebuild \
        -create-xcframework \
        -framework "$framework_name.framework-iphoneos.xcarchive/Products/Library/Frameworks/$framework_name.framework" \
        -framework "$framework_name.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/$framework_name.framework" \
        -output "$framework_name.xcframework"
}

function zip_xcframework() {
    local framework_name=$1

    cecho "Zipping $framework_name.xcframework"

    zip -r -X "$framework_name.xcframework.zip" "$framework_name.xcframework/"

    shasum -a 256 "$framework_name.xcframework.zip" >> checksums
}

cd $ROOT_DIR

tuist generate --no-open

rm -rf $BUILD_DIR
mkdir $BUILD_DIR
cd $BUILD_DIR

archive_project "GoogleMaps"
archive_project "GoogleMapsBase"
archive_project "GoogleMapsCore"
archive_project "GoogleMapsM4B"

create_xcframework "GoogleMaps"
create_xcframework "GoogleMapsBase"
create_xcframework "GoogleMapsCore"
create_xcframework "GoogleMapsM4B"

zip_xcframework "GoogleMaps"
zip_xcframework "GoogleMapsBase"
zip_xcframework "GoogleMapsCore"
zip_xcframework "GoogleMapsM4B"
