#!/usr/bin/env nix-shell
#!nix-shell shell.nix -i bash

url="https://github.com/$GITHUB_REPOSITORY"
rev="$GITHUB_SHA"
trap 'rm -f "$release_json" "$release_nix"' INT EXIT
release_json="$(mktemp "release-XXXXXXXXXX.json")"
release_nix="$(mktemp "release-XXXXXXXXXX.nix")"
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
hub release edit -m "" -a "$release_nix#release.nix" "$GITHUB_REF"