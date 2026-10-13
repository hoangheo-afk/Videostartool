#!/bin/bash
set -e

SDK="$(xcrun --sdk iphoneos --show-sdk-path 2>/dev/null || true)"
if [ -z "$SDK" ] || [ ! -d "$SDK" ]; then
    SDK="$(ls -d /Applications/Xcode*.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS*.sdk 2>/dev/null | tail -n 1)"
fi

if [ -z "$SDK" ] || [ ! -d "$SDK" ]; then
    echo "iPhoneOS SDK not found"
    exit 1
fi

echo "Using SDK: $SDK"

clang -dynamiclib \
    -arch arm64 -arch arm64e \
    -isysroot "$SDK" \
    -miphoneos-version-min=14.0 \
    -fobjc-arc \
    -framework UIKit \
    -framework Foundation \
    -framework StoreKit \
    -framework CoreGraphics \
    -o VideoStarTool.dylib \
    Tweak.x

if command -v ldid >/dev/null 2>&1; then
    ldid -S VideoStarTool.dylib
    echo "Signed with ldid"
fi

echo "Built: VideoStarTool.dylib"
file VideoStarTool.dylib || true
