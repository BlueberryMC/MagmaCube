#!/usr/bin/env bash
basedir="$(cd "$1" && pwd -P)"
clientJarUrl="https://launcher.mojang.com/v1/objects/1321521b2caf934f7fc9665aab7e059a7b2bfcdf/client.jar"
clientJarPath="$basedir"/work/Minecraft/client.jar
clientMappingUrl="https://launcher.mojang.com/v1/objects/faac5028fbca3859db970cc4ca041aeec55f6d9d/client.txt"
clientMappingPath="$basedir"/work/Minecraft/mapping.txt
clientRemappedJarPath="$basedir"/work/Minecraft/client-remapped.jar
decompilerUrl="https://github.com/kwart/jd-cmd/releases/download/jd-cmd-1.1.0.Final/jd-cli-1.1.0.Final-dist.zip"
decompilerPath="$basedir"/work/decompiler/jd.zip
decompilerDir="$basedir"/work/decompiler/
decompilerBin="$basedir"/work/decompiler/jd-cli.jar
decompOutput="$basedir"/work/Minecraft/source
git="git -c commit.gpgsign=false"
rm -rf "$decompilerDir"
rm -rf "$basedir"/Minecraft/src/main
rm -rf "$basedir"/work/Minecraft/source
mkdir -p "$basedir"/Minecraft/src/main/java
mkdir -p "$decompilerDir"
mkdir -p "$decompOutput"
echo "Downloading client jar..."
curl $clientJarUrl --output "$clientJarPath"
if [ $? != 0 ]; then
  echo "Could not download client jar, please check for errors above, fix it, then run again."
  exit 1
fi
echo "Downloading client mapping..."
curl $clientMappingUrl --output "$clientMappingPath"
if [ $? != 0 ]; then
  echo "Could not download client mapping, please check for errors above, fix it, then run again."
  exit 1
fi
echo "Downloading decompiler..."
curl -L "$decompilerUrl" --output "$decompilerPath"
if [ $? != 0 ]; then
  echo "Could not download decompiler, please check for errors above, fix it, then run again."
  exit 1
fi
echo "Unpacking decompiler..."
unzip "$decompilerPath" -d "$decompilerDir"
if [ $? != 0 ]; then
  echo "Could not unzip decompiler, please fix the error(s) above, then run again."
  exit 1
fi
echo "Applying mapping"
"$basedir"/work/MC-Remapper/bin/MC-Remapper --fixlocalvar=rename --output="$clientRemappedJarPath" "$clientJarPath" "$clientMappingPath"
echo "Decompiling the remapped jar..."
java -Xmx4G -jar "$decompilerBin" -od "$decompOutput" "$clientRemappedJarPath"
echo "Copying files"
rm -rf "$basedir"/Minecraft/src/main/resources
rm -rf "$basedir"/Minecraft/src/main/java
mkdir -p "$basedir"/work/Minecraft/source/src/main/resources
mkdir -p "$basedir"/work/Minecraft/source/src/main/java
mv "$basedir"/work/Minecraft/source/net "$basedir"/work/Minecraft/source/src/main/java/
mv "$basedir"/work/Minecraft/source/com "$basedir"/work/Minecraft/source/src/main/java/
mv "$basedir"/work/Minecraft/source/data "$basedir"/work/Minecraft/source/src/main/resources/
mv "$basedir"/work/Minecraft/source/META-INF "$basedir"/work/Minecraft/source/src/main/resources/
mv "$basedir"/work/Minecraft/source/assets "$basedir"/work/Minecraft/source/src/main/resources/
mv "$basedir"/work/Minecraft/source/log4j2.xml "$basedir"/work/Minecraft/source/src/main/resources/
mv "$basedir"/work/Minecraft/source/pack.mcmeta "$basedir"/work/Minecraft/source/src/main/resources/
mv "$basedir"/work/Minecraft/source/pack.png "$basedir"/work/Minecraft/source/src/main/resources/
mv "$basedir"/work/Minecraft/source/version.json "$basedir"/work/Minecraft/source/src/main/resources/
rm "$basedir"/work/Minecraft/source/src/main/resources/META-INF/MOJANGCS.RSA
rm "$basedir"/work/Minecraft/source/src/main/resources/META-INF/MOJANGCS.SF
cp -rf "$basedir"/work/Minecraft/source/src/main/java "$basedir"/Minecraft/src/main/java
cp -rf "$basedir"/work/Minecraft/source/src/main/resources "$basedir"/Minecraft/src/main/resources
echo "Setting up git"
cd "$basedir/work/Minecraft/source/"
$git init
$git add src
$git commit -m "Vanilla $ $(date)" --author="Vanilla <auto@mated.null>"
$git status
echo "  Downloaded the client jar successfully"
