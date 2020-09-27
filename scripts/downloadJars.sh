#!/usr/bin/env bash
source ./scripts/functions.sh
procyondir="$basedir/work/procyon"
CLASSPATH=$CLASSPATH:$procyondir/jcommander.jar:$procyondir/procyon-core.jar:$procyondir/procyon-compilertools.jar:$procyondir/procyon-expressions.jar:$procyondir/procyon-reflection.jar:$procyondir/procyon-decompiler.jar
clientJarUrl="https://launcher.mojang.com/v1/objects/1321521b2caf934f7fc9665aab7e059a7b2bfcdf/client.jar"
clientJarPath="$basedir"/work/Minecraft/$version/client.jar
clientMappingUrl="https://launcher.mojang.com/v1/objects/faac5028fbca3859db970cc4ca041aeec55f6d9d/client.txt"
clientMappingPath="$basedir"/work/Minecraft/$version/mapping.txt
clientRemappedJarPath="$basedir"/work/Minecraft/$version/client-remapped.jar
clientRemapped2JarPath="$basedir"/work/Minecraft/$version/client-remapped2.jar
decompilerUrl="https://github.com/leibnitz27/cfr/releases/download/0.150/cfr-0.150.jar"
decompilerPath="$basedir"/work/decompiler/cfr.jar
decompilerBin="$basedir"/work/decompiler/cfr.jar
decompOutput="$basedir/work/Minecraft/$version/source"
decompOutput2="$basedir/work/Minecraft/$version/imports"
decompBin2="$basedir/work/procyon/procyon"
rm -rf "$basedir"/Minecraft/src/main
rm -rf "$basedir"/work/Minecraft/$version/source
mkdir -p "$basedir/work/decompiler"
mkdir -p "$basedir/Minecraft/src/main/java"
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
echo "Applying mapping"
"$basedir"/work/MC-Remapper/bin/MC-Remapper --fixlocalvar=rename --output="$clientRemappedJarPath" "$clientJarPath" "$clientMappingPath"
echo "Unpacking jar..."
rm -rf "$basedir/work/Minecraft/$version/unpacked"
mkdir -p "$basedir/work/Minecraft/$version/unpacked"
cd "$basedir/work/Minecraft/$version/unpacked"
unzip "$clientRemappedJarPath"
echo "Manifest-Version: 1.0" > "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF"
echo "Main-Class: net.minecraft.client.Main" >> "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF"
echo "" >> "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF"
rm "$basedir/work/Minecraft/$version/unpacked/META-INF/MOJANGCS.RSA"
rm "$basedir/work/Minecraft/$version/unpacked/META-INF/MOJANGCS.SF"
echo "Creating jar..."
jar cf "$clientRemapped2JarPath" "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF" .
cd "$basedir"
echo "Decompiling the remapped jar..."
rm -rf "$decompOutput"
rm -rf "$decompOutput2"
java -Xmx4G -jar "$decompilerBin" "$clientRemapped2JarPath" --outputdir "$decompOutput2" &
$decompBin2 -o "$decompOutput" "$clientRemapped2JarPath" &
wait
$basedir/scripts/importFiles.sh
$basedir/scripts/postDownload.sh
echo "  Downloaded the client jar successfully"
