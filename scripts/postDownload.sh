#!/usr/bin/env bash
source ./scripts/functions.sh
basedir="$(cd "$1" && pwd -P)"
decompOutput="$basedir"/work/Minecraft/$version/source
git="git -c commit.gpgsign=false"
echo "Processing files (it takes *VERY* long!)"
for file in $(find "$decompOutput" -mindepth 1 -type f); do
  echo $file
  iconv -f SHIFT-JIS -t UTF-8 $file > $file.bak
  rm $file
  mv $file.bak $file
  sed -zi 's/\/\/ \n\/\/ Decompiled by Procyon v0\.5\.32\n\/\/ \n\n//g' $file &
done
wait
./scripts/copyFiles.sh
