#!/bin/bash

# remove old installers
rm Disk\ Image/*.pkg

./build.sh

GIT_VERSION=$(git --version | sed 's/git version //')
PACKAGE_NAME="git-$GIT_VERSION-intel-leopard"
IMAGE_FILENAME="git-$GIT_VERSION-intel-leopard.dmg" 

echo $PACKAGE_NAME | pbcopy
echo "Git version is $GIT_VERSION"

open "Git Installer.pmdoc/"

echo "Once the package is built, press a key"
read -n 1

./test_installer.sh

printf "$GIT_VERSION" | pbcopy

UNCOMPRESSED_IMAGE_FILENAME="git-$GIT_VERSION-intel-leopard.uncompressed.dmg"
hdiutil create $UNCOMPRESSED_IMAGE_FILENAME -srcfolder "Disk Image" -volname "Git $GIT_VERSION Intel Leopard" -ov
hdiutil convert -format UDZO -o $IMAGE_FILENAME $UNCOMPRESSED_IMAGE_FILENAME
rm $UNCOMPRESSED_IMAGE_FILENAME

echo "Git Installer $GIT_VERSION - OS X - Leopard - Intel" | pbcopy
open "http://code.google.com/p/git-osx-installer/downloads/entry"
sleep 1
open "./"
