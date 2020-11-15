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
- World Generation is trash (Check ChunkGenerator)
- Can't break/place blocks (purely visual)
- Sometimes Minecraft hangs while updating lighting (light update taking forever)
- Chunk section sometimes disappear? (and comes back after)
- Some textures (blocks) are bugged
- There are blocks that can't pass through even if it's spectator mode
- Blocks are disappearing
- Can't use elytra in air
- Broken collision with non-solid blocks
- Some parts of blocks are transparent
- Does not render hidden blocks (e.g. block hidden under the chest)
- Broken skins? (renders as alex, or steve even if logged in with valid access token)

## Todo

## Things I noticed
- I think we can comment out (or modify the condition on Line 453) Line 454 on `net.minecraft.client.renderer.GameRenderer` to completely disable nausea effect
- We can write Line 258 at `net.minecraft.client.gui.screens.TitleScreen` to display custom title text

----

See [here](https://github.com/acrylic-style/MagmaCube/blob/master/CONTRIBUTING.md) for more information about building the project.
