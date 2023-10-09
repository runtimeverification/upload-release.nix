#!/usr/bin/env nix-shell
#!nix-shell shell.nix -i bash

url="https://github.com/$GITHUB_REPOSITORY"
rev="$GITHUB_SHA"
trap 'rm -fr "$release_tmp"' INT EXIT
release_tmp="$(mktemp --tmpdir -d "release-XXXXXXXXXX")"
release_json="$release_tmp/release.json"
release_nix="$release_tmp/release.nix"
nix-prefetch-git --url "$url" --rev "$rev" --fetch-submodules > "$release_json"
sha256=$(jq -r '.sha256' < "$release_json")
cat > "$release_nix" <<EOF
{
  url = "$url";
  sha256 = "$sha256";
  rev = "$rev";
  fetchSubmodules = true;
}
EOF
gh release upload "${GITHUB_REF#refs/tags/}" "$release_nix#release.nix"
