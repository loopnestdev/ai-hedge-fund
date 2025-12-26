# flake.nix
{
  description = "ai‑hedge‑fund development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pythonEnv = pkgs.python312.withPackages (ps: with ps; [
          requests pandas numpy jupyterlab
        ]);
      in {
        devShells.default = pkgs.mkShell {
          name = "ai-hedge-fund-shell";
          buildInputs = [ 
            pkgs.python312 
            pkgs.poetry 
            pythonEnv 
            pkgs.git 
            pkgs.wget 
          ];
          shellHook = ''
            echo ">>> Welcome to the ai‑hedge‑fund dev environment"
          '';
        };
      });
}
