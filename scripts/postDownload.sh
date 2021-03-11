#!/usr/bin/env bash
source ./scripts/functions.sh
basedir="$(cd "$1" && pwd -P)"
decompOutput="$basedir"/work/Minecraft/$version/source
git="git -c commit.gpgsign=false"
echo "Processing files at $decompOutput"
# it actually removes some of unnecessary/wrong casts
java -Xmx256M -jar "$basedir/work/UnusedCommentRemover/UnusedCommentRemover-1.0-SNAPSHOT.jar" "$decompOutput"
./scripts/copyFiles.sh
