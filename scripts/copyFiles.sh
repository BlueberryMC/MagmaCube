#!/usr/bin/env bash
source ./scripts/functions.sh
basedir="$(cd "$1" && pwd -P)"
git="git -c commit.gpgsign=false"
echo "Copying files"
rm -rf "$basedir"/Minecraft/src/main/resources
rm -rf "$basedir"/Minecraft/src/main/java
mkdir -p "$basedir"/work/Minecraft/$version/source/src/main/resources
mkdir -p "$basedir"/work/Minecraft/$version/source/src/main/java
mv -f "$basedir/work/Minecraft/$version/source/net" "$basedir/work/Minecraft/$version/source/src/main/java/"
mv -f "$basedir/work/Minecraft/$version/source/com" "$basedir/work/Minecraft/$version/source/src/main/java/"
mv -f "$basedir/work/Minecraft/$version/unpacked/data" "$basedir/work/Minecraft/$version/source/src/main/resources/"
mv -f "$basedir/work/Minecraft/$version/unpacked/META-INF" "$basedir/work/Minecraft/$version/source/src/main/resources/"
mv -f "$basedir/work/Minecraft/$version/unpacked/assets" "$basedir/work/Minecraft/$version/source/src/main/resources/"
mv -f "$basedir/work/Minecraft/$version/unpacked/log4j2.xml" "$basedir/work/Minecraft/$version/source/src/main/resources/"
#mv -f "$basedir/work/Minecraft/$version/unpacked/pack.mcmeta" "$basedir/work/Minecraft/$version/source/src/main/resources/"
mv -f "$basedir/work/Minecraft/$version/unpacked/pack.png" "$basedir/work/Minecraft/$version/source/src/main/resources/"
mv -f "$basedir/work/Minecraft/$version/unpacked/version.json" "$basedir/work/Minecraft/$version/source/src/main/resources/"
rm -rf "$basedir/work/Minecraft/$version/unpacked" & # remove unneeded folder in background
cp -rf "$basedir/work/Minecraft/$version/source/src/main/java" "$basedir/Minecraft/src/main/java"
cp -rf "$basedir/work/Minecraft/$version/source/src/main/resources" "$basedir/Minecraft/src/main/resources"
echo "Setting up git"
cd "$basedir/work/Minecraft/$version/source/" || exit 1
$git init
$git add src
$git commit -m "Vanilla $ $(date +%Y-%m-%dT%T%:z)" --author="Vanilla <auto@mated.null>"
$git status
