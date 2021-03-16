#!/usr/bin/env nix-shell
#!nix-shell shell.nix -i bash

url="${1:?}"; shift
rev="${1:?}"; shift
source_json="$(mktemp "release.sh-XXXXXXXXXX.json")"
trap 'rm -f "$source_json"' INT EXIT
nix-prefetch-git --url "$url" --rev "$rev" --fetch-submodules > "$source_json"
sha256=$(jq -r '.sha256' < "$source_json")
cat <<EOF
{
  url = "$url";
  sha256 = "$sha256";
  rev = "$rev";
  fetchSubmodules = true;
}
EOF
