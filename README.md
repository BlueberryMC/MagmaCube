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
| side | issue | things to check |
| ---- | ---- | ---- |
| client | Some blocks shows corrupted textures but works completely fine on item (both gui and item entity) | ModelBlockRenderer? |
| client | Some specific player animations does not stay (elytra and running) | |
| client/server | Missing collision checks with non-solid blocks | Block, Shapes, AABB |
| client | Some parts of blocks are transparent when there is carpet, snow on the side of the block | don't know where to check |
| client | Does not render hidden blocks (e.g. block hidden under the chest) | |
| client | Can't interact with anvil | BlockGetter#clipWithInteractionOverride, VoxelShape#clip(Vec3, Vec3, BlockPos) |
| client | Able to place blocks inside of the player | |
| client | Sometimes Minecraft hangs while updating lighting (light update taking forever) | see below |
| client | Joining some server causes light update hang | Fix infinite loop in net.minecraft.world.level.lighting.DynamicGraphMinFixedPoint#176 |
| server | Some chunk section becomes corrupted if chunk section contains some block entity | |
| client | ArrayIndexOutOfBoundsException when opening enchanting table | |
| server | Broken Pathfinder | |
| server | Some time after loading a world, StackOverflowError will be thrown on IOWorker | |
| server | server is very laggy | probably caused by broken Pathfinder? |

## Todo
- Check broken maths (like bit operations, missing `~` or type issue)

## Things I noticed
- I think we can comment out (or modify the condition on Line 453) Line 454 on `net.minecraft.client.renderer.GameRenderer` to completely disable nausea effect
- We can write Line 258 at `net.minecraft.client.gui.screens.TitleScreen` to display custom title text

----

See [here](https://github.com/acrylic-style/MagmaCube/blob/master/CONTRIBUTING.md) for more information about building the project.
