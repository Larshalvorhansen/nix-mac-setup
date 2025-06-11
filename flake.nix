{
  description =
    "My macOS config with nix-darwin, Home Manager, and Lean dev shell";

  inputs = {
    darwin.url = "github:lnl7/nix-darwin";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    { self, nixpkgs, darwin, home-manager, flake-utils, mac-app-util, ... }:
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

      # The hostname from the error message is used here
      darwinConfigurations."lhh" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          mac-app-util.darwinModules.default
          ./darwin/configuration.nix
          home-manager.darwinModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            home-manager.users.lhh = {
              imports =
                [ ./home/lhh.nix mac-app-util.homeManagerModules.default ];
            };
          }
        ];
      };
    };
}
