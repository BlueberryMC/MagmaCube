#!/usr/bin/env bash
basedir="$(cd "$1" && pwd -P)"
git="git -c commit.gpgsign=false -c core.safecrlf=false"
echo "Rebuilding patch files..."
mkdir -p "$basedir/patches"
cd "$basedir/patches" || exit 1
rm -rf -- *.patch
cd "$basedir/Minecraft" || exit 1
$git format-patch --zero-commit --full-index --no-signature --no-stat -N -o "$basedir/patches/" upstream/master >/dev/null
cd "$basedir" || exit 1
$git add -A "$basedir/patches"
cd "$basedir/patches" || exit 1
for patch in *.patch; do
  echo "$patch"
  diffs=$($git diff --staged "$patch" | grep --color=none -E "^(\+|\-)" | grep --color=none -Ev "(\-\-\- a|\+\+\+ b|^.index)")
  if [ "x$diffs" == "x" ] ; then
    $git reset HEAD "$patch" >/dev/null
    $git checkout -- "$patch" >/dev/null
  fi
done
echo "  Patches saved to patches/"
