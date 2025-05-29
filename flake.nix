{
  description =
    "My macOS config with nix-darwin, Home Manager, and Lean dev shell";

  inputs = {
    darwin.url = "github:lnl7/nix-darwin";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    inputs.aerospace.url = "github:aerospacewm/aerospace";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
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
    in {
      inherit (forAllSystems) devShells;

      darwinConfigurations."lhh" = darwin.lib.darwinSystem {
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
