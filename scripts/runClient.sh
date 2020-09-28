#!/usr/bin/env bash
source ./scripts/functions.sh
mkdir -p "./work/testClient"
cd "./work/testClient" || exit 1
mcpath="$basedir/Minecraft/target/Minecraft.jar"
version=$(git rev-parse HEAD | head -c 10)
javaw -Dlog4j.configuration=log4j2.xml -Xmx8G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -cp "$mcpath" net.minecraft.client.main.Main --version="$version" "$@"