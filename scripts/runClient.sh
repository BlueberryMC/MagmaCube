#!/usr/bin/env bash
source ./scripts/functions.sh
mkdir -p "./work/testClient"
cd "./work/testClient" || exit 1
mcpath="$basedir/Minecraft/target/Minecraft.jar"
cd "$basedir/Minecraft" || exit 1
version=$(git rev-parse HEAD | head -c 10)
cd "$basedir/work/testClient" || exit 1
ASSETS=~/.minecraft/assets
if [[ "$OSTYPE" == *"win"* || "$OSTYPE" == "msys" ]]; then
  ASSETS=~/AppData/Roaming/.minecraft/assets
fi
java -Dlog4j.configuration=log4j2.xml -Xmx8G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -cp "$mcpath" net.minecraft.client.main.Main --version="$version" --assetIndex=1.17 --versionType debug --username="Dev" --uuid="abc" --accessToken="abc" --assetsDir="$ASSETS" --gameDir="$basedir/work/testClient" "$@"
