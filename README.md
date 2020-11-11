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
- Spectator mode is broken, can't pass through blocks
- World Generation is trash
- Some translations aren't showing correctly
- Not loading some textures(= Models?)
- Cannot break/place blocks in single player (If I place it, it will disappear when I right clicked the placed block)
- Not rendering models at all ("missing model" too!) (Most GUIs are rendered correctly)

## Todo
- Fix GuiComponent#fill

## Things I noticed
- I think we can comment out (or modify the condition on Line 453) Line 454 on `net.minecraft.client.renderer.GameRenderer` to completely disable nausea effect
- We can write Line 258 at `net.minecraft.client.gui.screens.TitleScreen` to display custom title text

----

See [here](https://github.com/acrylic-style/MagmaCube/blob/master/CONTRIBUTING.md) for more information about building the project.
