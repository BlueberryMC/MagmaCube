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
| Blocks are disappearing | check around block interaction | |
| Some specific player animations does not stay (elytra and running) | |
| Broken collision with non-solid blocks | |
| Some parts of blocks are transparent | LevelRenderer#renderVoxelShape? |
| Does not render hidden blocks (e.g. block hidden under the chest) | |
| Broken skins? (renders as alex, or steve even if logged in with valid access token) | |
| Can't break/place blocks (purely visual) | see below |
| Does not render the changed blocks | check MultiPlayerGameMode |
| Sometimes Minecraft hangs while updating lighting (light update taking forever) | see below |
| Joining some server causes light update hang | fixed temporarily in net.minecraft.world.level.lighting.DynamicGraphMinFixedPoint#176 |
| Block update (notify) is messed up | |
| Cannot create a world | visibleChunkMap in ChunkMap |

## Todo
- ~~Check around int -> double/float casts~~ still happening even if we did this?
- Check around Line 125 in net.minecraft.client.multiplayer.MultiPlayerGameMode

## Things I noticed
- I think we can comment out (or modify the condition on Line 453) Line 454 on `net.minecraft.client.renderer.GameRenderer` to completely disable nausea effect
- We can write Line 258 at `net.minecraft.client.gui.screens.TitleScreen` to display custom title text

----

See [here](https://github.com/acrylic-style/MagmaCube/blob/master/CONTRIBUTING.md) for more information about building the project.
