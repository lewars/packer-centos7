#!/bin/bash
#
# iso.sh - Create a macosx ISO from a legitimate install application.
set -xe

hdiutil attach "/Applications/Install OS X El Capitan.app/Contents/SharedSupport/InstallESD.dmg" -noverify -nobrowse -mountpoint /Volumes/esd
hdiutil create -o ElCapitan3 -size 7316m -layout SPUD -fs HFS+J
hdiutil attach ElCapitan3.dmg -noverify -nobrowse -mountpoint /Volumes/iso
asr restore -source /Volumes/esd/BaseSystem.dmg -target /Volumes/iso -noprompt -erase --SHA256
rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
cp -rp /Volumes/esd/Packages /Volumes/OS\ X\ Base\ System/System/Installation
cp -rp /Volumes/esd/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/
cp -rp /Volumes/esd/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/
hdiutil detach /Volumes/esd
hdiutil detach /Volumes/OS\ X\ Base\ System
hdiutil convert ElCapitan3.dmg -format UDTO -o ElCapitan3.iso
mv ElCapitan3.iso.cdr ElCapitan3.iso
