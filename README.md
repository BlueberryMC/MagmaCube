# MagmaCube

## What's this

A Minecraft that you can patch your own patches into the Minecraft.

Based on MC 1.16.4 currently.

## Current goal
- Make it work, without bugs.
- Understand the code

## Goal
- Make it editable easily by everyone who wants to code Minecraft
- Complete compatibility with vanilla

## Note
- You should not use this project for any bad usages
- Do not redistribute the jar file, without any exception. It is against the Mojang's ToS.

## Bugs
| issue | things to check |
| ---- | ---- |
| world (chunk) generation is trash | check ChunkGenerator, NoiseBasedChunkGenerator |
| Chunk section sometimes disappear? (and comes back after) | |
| Some textures (blocks) are bugged | |
| There are blocks that can't pass through even if it's spectator mode | |
| Blocks are disappearing | Check around block interaction, almost all invocation of Level#setBlock and PacketListener seems not related |
| Some specific player animations does not stay (elytra and running) | |
| Broken collision with non-solid blocks | |
| Some parts of blocks are transparent | LevelRenderer#renderShape? |
| Does not render hidden blocks (e.g. block hidden under the chest) | |
| Broken skins on multiplayer? (renders as alex, or steve. single player works fine) | |
| Can't break/place blocks (purely visual) | see below |
| Does not render the changed blocks | check MultiPlayerGameMode |
| Sometimes Minecraft hangs while updating lighting (light update taking forever) | see below |
| Joining some server causes light update hang | fixed temporarily in net.minecraft.world.level.lighting.DynamicGraphMinFixedPoint#176 |
| Block update (notify) is messed up | |
| Cannot create a world | visibleChunkMap in ChunkMap |

## Todo
- Check around Line 125 in net.minecraft.client.multiplayer.MultiPlayerGameMode
- rename "Invalid" to "Invalid \[enum name]" in switch in DebugScreenOverlay#getGameInformation

## Things I noticed
- Comment out (or modify the condition on Line 453) Line 454 on `net.minecraft.client.renderer.GameRenderer` to completely disable nausea effect
- Write Line 258 at `net.minecraft.client.gui.screens.TitleScreen` to display custom title text
- Modify player name tag with `PlayerRenderer#renderNameTag`
- enable debug renders at DebugRenderer
- PlayerTabOverlay to modify how tab renders on multiplayer
- what are private final fields on net.minecraft.server.network.TextFilterClient?

----

See [here](https://github.com/acrylic-style/MagmaCube/blob/master/CONTRIBUTING.md) for more information about building the project.
