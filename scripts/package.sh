#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

VERSION="$(tr -d '[:space:]' < VERSION.txt)"

PACKAGE_NAME="BugBountyWordlistsPro-${VERSION}"
RELEASE_DIR="$ROOT_DIR/release"
PACKAGE_DIR="$RELEASE_DIR/$PACKAGE_NAME"
ZIP_FILE="$RELEASE_DIR/$PACKAGE_NAME.zip"

echo "[*] Building..."
./scripts/build.sh

rm -rf "$PACKAGE_DIR"
rm -f "$ZIP_FILE"

mkdir -p "$PACKAGE_DIR"

cp README.md "$PACKAGE_DIR/"
cp CHANGELOG.md "$PACKAGE_DIR/"
cp LICENSE.txt "$PACKAGE_DIR/"
cp VERSION.txt "$PACKAGE_DIR/"

cp -r wordlists "$PACKAGE_DIR/"
cp -r cli "$PACKAGE_DIR/"
cp -r docs "$PACKAGE_DIR/"

mkdir -p "$PACKAGE_DIR/scripts"

cp scripts/install.sh "$PACKAGE_DIR/scripts/"
cp scripts/check.sh "$PACKAGE_DIR/scripts/"
cp scripts/stats.sh "$PACKAGE_DIR/scripts/"

chmod +x "$PACKAGE_DIR/cli/bbwp"
chmod +x "$PACKAGE_DIR/scripts/"*.sh

(
    cd "$RELEASE_DIR"
    zip -qr "$PACKAGE_NAME.zip" "$PACKAGE_NAME"
)

sha256sum "$ZIP_FILE" > "$ZIP_FILE.sha256"

echo
echo "[+] Release created:"
ls -lh "$ZIP_FILE"
echo
cat "$ZIP_FILE.sha256"
