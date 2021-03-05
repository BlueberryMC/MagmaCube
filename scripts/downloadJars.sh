#!/usr/bin/env bash
source ./scripts/functions.sh
clientJarUrl="https://launcher.mojang.com/v1/objects/c8ae0a1a8b18841e009b8dcdf21ec014f5787410/client.jar"
clientJarPath="$basedir"/work/Minecraft/$version/client.jar
clientMappingUrl="https://launcher.mojang.com/v1/objects/3cade11677a20fbd46c83edc8d90f7df465b3ff5/client.txt"
clientMappingPath="$basedir"/work/Minecraft/$version/mapping.txt
clientRemappedJarPath="$basedir"/work/Minecraft/$version/client-remapped.jar
decompilerBin="$basedir"/work/ForgeFlower/forgeflower-1.5.478.18.jar
quickunzip="$basedir/work/quickunzip/quickunzip.jar"
decompOutput="$basedir/work/Minecraft/$version/source"
rm -rf "$basedir/Minecraft/src/main"
rm -rf "$basedir/work/Minecraft/$version/source"
mkdir -p "$basedir/work/decompiler"
mkdir -p "$basedir/Minecraft/src/main/java"
mkdir -p "$decompOutput"
git submodule update --init
cd "$basedir/work/mappings" || exit 1
echo "Checked out: mappings: $(git log --oneline HEAD -1)"
cd "$basedir" || exit 1
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
echo "Applying mapping"
"$basedir"/work/MC-Remapper/bin/MC-Remapper --fixlocalvar=rename --output-name="$clientRemappedJarPath" "$clientJarPath" "$clientMappingPath"
java -Xmx2G -jar "$basedir/work/ParameterRemapper/ParameterRemapper-1.0.2.jar" --input-file="$clientRemappedJarPath" --output-file="$clientRemappedJarPath.2" --mapping-file="$basedir/work/mappings/mappings/$version.pr"
java -Xmx2G -jar "$basedir/work/AccessTransformers/accesstransformers-3.0.1-fatjar.jar" --inJar "$clientRemappedJarPath.2" --outJar "$clientRemappedJarPath" --atFile "$basedir/work/mappings/mappings/$version.at"
echo "Deleting intermediate jar"
rm "$clientRemappedJarPath.2"
echo "Unpacking jar..."
rm -rf "$basedir/work/Minecraft/$version/unpacked"
mkdir -p "$basedir/work/Minecraft/$version/unpacked"
cd "$basedir/work/Minecraft/$version/unpacked" || exit 1
java -Xmx1G -jar "$quickunzip" -q "$clientRemappedJarPath" "$basedir/work/Minecraft/$version/unpacked/"
echo "Manifest-Version: 1.0" > "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF"
echo "Main-Class: net.minecraft.client.Main" >> "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF"
echo "" >> "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF"
rm "$basedir/work/Minecraft/$version/unpacked/META-INF/MOJANGCS.RSA"
rm "$basedir/work/Minecraft/$version/unpacked/META-INF/MOJANGCS.SF"
cd "$basedir" || exit 1
echo "Decompiling the remapped jar..."
rm -rf "$decompOutput"
mkdir -p "$decompOutput"
java -Xmx4G -jar "$decompilerBin" -dgs=1 -rsy=1 "$basedir/work/Minecraft/$version/unpacked" "$decompOutput"
$basedir/scripts/postDownload.sh
echo "  Downloaded the client jar successfully"
