# GitHub Action - Upload release.nix

## Problem

Your repository includes Nix expressions that depend on submodules.
GitHub source archives do not include submodules,
so you need a clone of the repository to import the expressions.

## Solution

Upload a `release.nix` lock file for each release,
containing the revision and the hash,
so that you can use `fetchgit` to clone the repository with submodules and import expressions.

## Usage

Create a GitHub Actions workflow triggered on the creation of releases.
The job should check out the repository, install Nix, and use this action:

``` yaml
name: "Release"
on:
  release:
    types:
      - created

jobs:
  nix-release:
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v2.3.4
        with:
          submodules: recursive

      - name: Install Nix
        uses: cachix/install-nix-action@v12

      - name: Upload release.nix
        uses: ttuegel/upload-release.nix@v1.0
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
```
