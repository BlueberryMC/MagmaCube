#!/usr/bin/env bash
./scripts/downloadJars.sh || exit 1
./scripts/applyPatches.sh
