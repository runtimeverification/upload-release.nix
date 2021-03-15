#!/usr/bin/env nix-shell
#!nix-shell shell.nix -i bash

url="${1:?}"; shift
rev="${1:?}"; shift
source_json="$(mktemp "release.sh-XXXXXXXXXX.json")"
trap 'rm -f "$source_json"' INT EXIT
nix-prefetch-git --url "$url" --rev "$rev" --fetch-submodules > "$source_json"
sha256=$(jq -r '.sha256' < "$source_json")
sed release.template.nix \
    -e "s;@url@;$url;" \
    -e "s;@rev@;$rev;" \
    -e "s;@sha256@;$sha256;"