#!/bin/bash
# ライブコードエディタ.app ビルドスクリプト
# 使い方: プロジェクトフォルダで bash native/build.sh
set -euo pipefail
cd "$(dirname "$0")/.."

APP="ライブコードエディタ.app"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources/web"

cp native/Info.plist "$APP/Contents/Info.plist"
cp index.html style.css app.js "$APP/Contents/Resources/web/"

swiftc -O -o "$APP/Contents/MacOS/LiveCodeEditor" native/main.swift \
  -framework AppKit -framework WebKit

codesign --force --deep --sign - "$APP" 2>/dev/null || true
echo "BUILD_OK: $APP"
