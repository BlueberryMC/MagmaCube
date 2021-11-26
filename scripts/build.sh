#!/usr/bin/env bash
version=""
basedir=""
source ./scripts/functions.sh

datetime=$(date +%Y-%m-%dT%T%:z)
cd ./Minecraft || exit 1
commit=$(git rev-parse HEAD | head -c 10)
cd "$basedir" || exit 1
version_json="$basedir/Minecraft/src/main/resources/version.json"
version_json_bak="$basedir/Minecraft/src/main/resources/version.json.bak"
cp "$version_json" "$version_json_bak" || exit 1
echo "{" > "$version_json"
echo "  \"id\": \"$version\"," >> "$version_json"
echo "  \"name\": \"$name\"," >> "$version_json"
echo "  \"release_target\": \"$releaseTarget\"," >> "$version_json"
echo "  \"magmacube_version\": \"$commit\"," >> "$version_json"
echo "  \"world_version\": $WORLD_VERSION," >> "$version_json"
echo "  \"series_id\": \"$seriesId\"," >> "$version_json"
echo "  \"protocol_version\": $PROTOCOL_VERSION," >> "$version_json"
echo "  \"pack_version\": {" >> "$version_json"
echo "    \"resource\": $RESOURCE_VERSION," >> "$version_json"
echo "    \"data\": $DATA_VERSION" >> "$version_json"
echo "  }," >> "$version_json"
echo "  \"build_time\": \"$datetime\"," >> "$version_json"
echo "  \"java_component\": \"java-runtime-beta\"," >> "$version_json"
echo "  \"java_version\": 17," >> "$version_json"
echo "  \"stable\": $stable" >> "$version_json"
echo "}" >> "$version_json"
cat "$version_json"
mvn clean install || exit 1
cp "$version_json_bak" "$version_json" || exit 1
rm "$version_json_bak"
