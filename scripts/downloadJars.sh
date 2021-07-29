#!/usr/bin/env bash
source ./scripts/functions.sh
clientJarUrl="https://launcher.mojang.com/v1/objects/1108159d2734fda202c782ff08e74bf1e399bad4/client.jar"
clientJarPath="$basedir"/work/Minecraft/$version/client.jar
clientMappingUrl="https://launcher.mojang.com/v1/objects/e40574bb0e42a3a2e9fd486db7f7dcd5e5d0c165/client.txt"
clientMappingPath="$basedir"/work/Minecraft/$version/mapping.txt
clientRemappedJarPath="$basedir"/work/Minecraft/$version/client-remapped.jar
decompilerBin="$basedir"/work/ForgeFlower/forgeflower-1.5.498.13.jar
quickunzip="$basedir/work/quickunzip/quickunzip.jar"
decompOutput="$basedir/work/Minecraft/$version/source"
# Remove files that was used previously
rm -rf "$basedir/Minecraft/src/main"
rm -rf "$basedir/work/Minecraft/$version/source"
mkdir -p "$basedir/work/decompiler"
mkdir -p "$basedir/Minecraft/src/main/java"
mkdir -p "$decompOutput"
# Check mappings
cd "$basedir/work/mappings" || exit 1
echo "Checked out: mappings: $(git log --oneline HEAD -1)"
cd "$basedir" || exit 1
# Download files
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
"$basedir"/work/MC-Remapper/bin/MC-Remapper --fixlocalvar=rename --output-name="$clientRemappedJarPath" "$clientJarPath" "$clientMappingPath" || exit 1
java -Xmx2G -jar "$basedir/work/ParameterRemapper/ParameterRemapper-1.0.2.jar" --input-file="$clientRemappedJarPath" --output-file="$clientRemappedJarPath.2" --mapping-file="$basedir/work/mappings/mappings/$version.pr" || exit 1
java -Xmx2G -jar "$basedir/work/AccessTransformers/accesstransformers-3.0.1-fatjar.jar" --inJar "$clientRemappedJarPath.2" --outJar "$clientRemappedJarPath" --atFile "$basedir/work/mappings/mappings/$version.at" || exit 1
echo "Deleting intermediate jar"
rm "$clientRemappedJarPath.2"
echo "Unpacking jar..."
rm -rf "$basedir/work/Minecraft/$version/unpacked"
mkdir -p "$basedir/work/Minecraft/$version/unpacked"
cd "$basedir/work/Minecraft/$version/unpacked" || exit 1
java -Xmx1G -jar "$quickunzip" -q "$clientRemappedJarPath" "$basedir/work/Minecraft/$version/unpacked/" || exit 1
echo "Manifest-Version: 1.0" > "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF"
echo "Main-Class: net.minecraft.client.Main" >> "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF"
echo "" >> "$basedir/work/Minecraft/$version/unpacked/META-INF/MANIFEST.MF"
rm "$basedir/work/Minecraft/$version/unpacked/META-INF/MOJANGCS.RSA"
rm "$basedir/work/Minecraft/$version/unpacked/META-INF/MOJANGCS.SF"
cd "$basedir" || exit 1
echo "Decompiling the remapped jar..."
rm -rf "$decompOutput"
mkdir -p "$decompOutput"
java -Xmx4G -jar "$decompilerBin" -dgs=1 -rsy=1 "$basedir/work/Minecraft/$version/unpacked" "$decompOutput" || exit 1
$basedir/scripts/postDownload.sh || exit 1
echo "  Downloaded the client jar successfully"
