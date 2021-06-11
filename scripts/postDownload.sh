#!/usr/bin/env bash
source ./scripts/functions.sh
basedir="$(cd "$1" && pwd -P)"
decompOutput="$basedir"/work/Minecraft/$version/source
git="git -c commit.gpgsign=false"
echo "Processing files at $decompOutput"
# it removes some unnecessary/wrong casts and "fix"es invalid characters
java -Xmx512M -jar "$basedir/work/UnusedCommentRemover/UnusedCommentRemover-1.0.4.jar" "$decompOutput"
./scripts/copyFiles.sh
