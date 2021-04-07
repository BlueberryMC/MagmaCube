# MagmaCube

## What's this

A Minecraft that you can patch your own patches into the Minecraft.

Based on MC 21w13a (snapshot for 1.17) currently.

## Goal
- Make it editable easily by everyone who wants to code Minecraft

## Note
- You should not use this project for any bad usages
- Do not redistribute the jar file, without any exception. It is against the Mojang's ToS.

## Bugs
- ~~Progress of Furnace screen is not moving (it's just visual bug)~~

## Things I noticed
- Modify player name tag with `PlayerRenderer#renderNameTag`
- enable debug renderers at DebugRenderer
- PlayerTabOverlay to modify how tab renders on multiplayer

## Available properties, environment variables
Properties can be set via jvm argument `-Dkey=value`.

| property | environment variables | what |
| --- | --- | --- |
| `magmacube.ignorePacketError` | `magmacubeIgnorePacketError` | whether to log `Packet xx was larger than I expected` errors, rather than throwing exception then interrupting connection |

----

See [here](https://github.com/BlueberryMC/MagmaCube/blob/master/CONTRIBUTING.md) for more information about building the project.
