let
  sources = import ./nix/sources.nix;
  pkgs = import sources."nixpkgs" { overlays = []; config = {}; };
  inherit (pkgs) mkShell nix-prefetch-scripts jq;
in

mkShell {
  buildInputs = [ nix-prefetch-scripts jq ];
}
