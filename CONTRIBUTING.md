# Contributing

We merge pull requests that makes sense.

## How to build MagmaCube (How to apply patches)
- Clone the repo
- Run `./magma patch` (If you're using windows, use git bash) (you'll need to wait for a long, so be patient)
- Edit away!

## How to run MagmaCube
- First, build the project with `./scripts/build.sh`
- Set game directory that MagmaCube will run at (-> Path #1)
- See where is assets folder in .minecraft, and copy them. (-> Path #2)
- Run this: `./scripts/runClient.sh`

## How to rebuild patches (Saving patches)
- Every single commit is a single patch file.
- Commit files before rebuilding patches.
- Just do `./magma rebuild`. This does not modify project, it only modifies the Minecraft-Patches directory.
