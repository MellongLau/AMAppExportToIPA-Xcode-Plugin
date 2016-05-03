#!/bin/sh

DECODE_FILE_PATH=$1
TARGET_FILE_PATH=$2

EXPORT_DIR=~/Desktop/AM_Builds

mkdir $EXPORT_DIR

xcrun -sdk iphoneos PackageApplication -v "$DECODE_FILE_PATH" -o "$EXPORT_DIR/$TARGET_FILE_PATH"
open -R "$EXPORT_DIR/$TARGET_FILE_PATH"

BUNDLE_IDENTIFIER=$(defaults read "${DECODE_FILE_PATH}/Info.plist" CFBundleIdentifier)
echo BUNDLE_IDENTIFIER is $BUNDLE_IDENTIFIER
BUNDLE_NAME=$(defaults read "${DECODE_FILE_PATH}/Info.plist" CFBundleName)
echo BUNDLE_NAME is $BUNDLE_NAME