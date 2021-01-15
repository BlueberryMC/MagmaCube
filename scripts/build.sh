#!/usr/bin/env bash
version=""
basedir=""
source ./scripts/functions.sh
WORLD_VERSION=2586
PROTOCOL_VERSION=754
PACK_VERSION=6

datetime=$(date +%Y-%m-%dT%T%:z)
cd ./Minecraft || exit 1
commit=$(git rev-parse HEAD | head -c 10)
cd "$basedir" || exit 1
version_json="$basedir/Minecraft/src/main/resources/version.json"
version_json_bak="$basedir/Minecraft/src/main/resources/version.json.bak"
cp "$version_json" "$version_json_bak" || exit 1
echo "{" > "$version_json"
echo "  \"id\": \"$version\"," >> "$version_json"
echo "  \"name\": \"$version\"," >> "$version_json"
echo "  \"release_target\": \"$version\"," >> "$version_json"
echo "  \"magmacube_version\": \"$commit\"," >> "$version_json"
echo "  \"world_version\": $WORLD_VERSION," >> "$version_json"
echo "  \"protocol_version\": $PROTOCOL_VERSION," >> "$version_json"
echo "  \"pack_version\": $PACK_VERSION," >> "$version_json"
echo "  \"build_time\": \"$datetime\"," >> "$version_json"
echo "  \"stable\": false" >> "$version_json"
echo "}" >> "$version_json"
cat "$version_json"
mvn clean install
cp "$version_json_bak" "$version_json" || exit 1
rm "$version_json_bak"
