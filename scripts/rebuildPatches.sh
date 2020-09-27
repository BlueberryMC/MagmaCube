#!/usr/bin/env bash
basedir="$(cd "$1" && pwd -P)"
git="git -c commit.gpgsign=false -c core.safecrlf=false"
echo "Rebuild patch files..."
mkdir -p "$basedir/Minecraft-Patches"
cd "$basedir/Minecraft-Patches"
rm -rf *.patch
cd "$basedir/Minecraft"
$git format-patch --zero-commit --full-index --no-signature --no-stat -N -o "$basedir/Minecraft-Patches/" upstream/master >/dev/null
cd "$basedir"
$git add -A "$basedir/Minecraft-Patches"
cd "$basedir/Minecraft-Patches"
for patch in *.patch; do
  echo "$patch"
  diffs=$($git diff --staged "$patch" | grep --color=none -E "^(\+|\-)" | grep --color=none -Ev "(\-\-\- a|\+\+\+ b|^.index)")
  if [ "x$diffs" == "x" ] ; then
    $git reset HEAD "$patch" >/dev/null
    $git checkout -- "$patch" >/dev/null
  fi
done
echo "  Patches saved for Minecraft to Minecraft-Patches/"
