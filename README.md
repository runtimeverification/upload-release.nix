# GitHub Action - Upload release.nix

**Problem:**
GitHub source archives do not include submodules.
If a project depends on submodules,
we can only import Nix expressions from a full Git clone;
we cannot import Nix expressions from a source tarball.

**Solution:**
Upload a `release.nix` asset to every release with the revision and hash,
so that we can use `fetchgit` to get a full clone and import expressions.