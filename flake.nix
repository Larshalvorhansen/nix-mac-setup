{
  description =
    "My macOS config with nix-darwin, Home Manager, and Lean dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    darwin.url = "github:lnl7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, ... }:
    let
      forAllSystems = flake-utils.lib.eachDefaultSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          devShells.default = pkgs.mkShell {
            buildInputs =
              [ pkgs.lean4 pkgs.lake pkgs.lean4Packages.lean-language-server ];

            shellHook = ''
              echo "Lean dev shell ready!"
            '';
          };
        });
    in flake-utils.lib.flattenTree {
      inherit (forAllSystems) devShells;

      darwinConfigurations."Lars-sin-MacBook-Pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lhh = import ./home/lhh.nix;
          }
        ];
      };
    };
}
