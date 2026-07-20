#!/usr/bin/env bash

VERSION=$(cat VERSION.txt)

rm -rf release/*

mkdir -p release/BugBountyWordlistsPro-$VERSION

cp -r README.md \
LICENSE.txt \
CHANGELOG.md \
VERSION.txt \
wordlists \
release/BugBountyWordlistsPro-$VERSION/

cd release

zip -r BugBountyWordlistsPro-$VERSION.zip BugBountyWordlistsPro-$VERSION

echo
echo "Package created:"
ls -lh *.zip
