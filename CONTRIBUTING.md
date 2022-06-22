# Contributing

We merge pull requests that makes sense.

## How to build MagmaCube (How to apply patches)
- Clone the repo
- Run `./magma patch` (If you're using windows, use git bash) (you'll need to wait for a long, so be patient)
- Edit away!

## How to run MagmaCube

### With IntelliJ IDEA
- Run the client with appropriate arguments

### With shell script
1. First, build the project with `./scripts/build.sh`
2. Set game directory that MagmaCube will run at (-> Path #1)
3. See where is assets folder in .minecraft, and copy them. (-> Path #2)
4. Run this: `./scripts/runClient.sh --accessToken=abc --userType=mojang --uuid=0 --username=Dev --gameDir=(Path #1) --assetsDir=(Path #2) --assetIndex=1.19`

## How to rebuild patches (Saving patches)
- Every single commit is a single patch file.
- Commit files before rebuilding patches.
- Just do `./magma rebuild`. This does not modify project, it only modifies the `patches` directory.
