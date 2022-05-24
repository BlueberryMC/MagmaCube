#!/usr/bin/env bash
source ./scripts/functions.sh
clientJarUrl="https://launcher.mojang.com/v1/objects/9dff887a5fe3109ed66dec7dc15878c1d4d3887c/client.jar"
clientJarPath="$basedir"/work/Minecraft/$version/client.jar
clientMappingUrl="https://launcher.mojang.com/v1/objects/3f9a517db9a51d10de3bfb5642c7134751586133/client.txt"
clientMappingPath="$basedir"/work/Minecraft/$version/mapping.txt
clientRemappedJarPath="$basedir"/work/Minecraft/$version/client-remapped.jar
FF_URL="https://maven.minecraftforge.net/net/minecraftforge/forgeflower/1.5.498.29/forgeflower-1.5.498.29.jar"
decompilerBin="$basedir"/work/ForgeFlower/forgeflower-1.5.498.29.jar
quickunzip="$basedir/work/quickunzip/quickunzip.jar"
decompOutput="$basedir/work/Minecraft/$version/source"
# Remove files that was used previously
rm -rf "$basedir/Minecraft/src/main"
rm -rf "$basedir/work/Minecraft/$version/source"
#mkdir -p "$basedir/work/decompiler"
mkdir -p "$basedir/work/ForgeFlower"
mkdir -p "$basedir/Minecraft/src/main/java"
mkdir -p "$decompOutput"
# Check mappings
cd "$basedir/work/mappings" || exit 1
echo "Checked out: mappings: $(git log --oneline HEAD -1)"
cd "$basedir" || exit 1
# Download files
echo "Downloading ForgeFlower..."
curl $FF_URL --output "$decompilerBin" || (
  echo "Could not download ForgeFlower, please check for errors above, fix it, then run again."
  exit 1
)
echo "Downloading client jar..."
curl $clientJarUrl --output "$clientJarPath" || (
  echo "Could not download client jar, please check for errors above, fix it, then run again."
  exit 1
)
echo "Downloading client mapping..."
curl $clientMappingUrl --output "$clientMappingPath" || (
  echo "Could not download client mapping, please check for errors above, fix it, then run again."
  exit 1
)
echo "Applying mapping"
"$basedir"/work/MC-Remapper/bin/MC-Remapper --fixlocalvar=rename --output-name="$clientRemappedJarPath" "$clientJarPath" "$clientMappingPath" || exit 1
java -Xmx2G -jar "$basedir/work/ParameterRemapper/ParameterRemapper-1.0.4.jar" --input-file="$clientRemappedJarPath" --output-file="$clientRemappedJarPath.2" --mapping-file="$basedir/work/mappings/mappings/$MAPPINGS_VERSION.pr" || exit 1
echo "Applying AccessTransformers"
java -Xmx2G -jar "$basedir/work/AccessTransformers/accesstransformers-8.0.4-fatjar.jar" --inJar "$clientRemappedJarPath.2" --outJar "$clientRemappedJarPath" --atFile "$basedir/work/mappings/mappings/$MAPPINGS_VERSION.at" || exit 1
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
java -Xmx4G -jar "$decompilerBin" -dgs=1 -rsy=1 -ind="    " -log="WARN" -mpm=30 "$basedir/work/Minecraft/$version/unpacked" "$decompOutput" || exit 1
$basedir/scripts/postDownload.sh || exit 1
echo "  Downloaded the client jar successfully"
