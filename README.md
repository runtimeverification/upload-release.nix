# GitHub Action - Upload release.nix

**Problem:**
Your repository includes Nix expressions that depend on submodules.
GitHub source archives do not include submodules,
so you need a clone of the repository to import the expressions.

**Solution:**
Upload a `release.nix` lock file for each release,
containing the revision and the hash,
so that you can use `fetchgit` to clone the repository with submodules and import expressions.
