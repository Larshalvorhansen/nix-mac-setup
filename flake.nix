{
  description =
    "My macOS config with nix-darwin, Home Manager, and Lean dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    mac-app-util.url = "github:hraban/mac-app-util";
    flake-utils.url = "github:numtide/flake-utils";
    # aerospace = { url = "github:nikitabobko/aerospace"; };
  };

  outputs =
    { self, nixpkgs, darwin, home-manager, flake-utils, mac-app-util, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs =
            [ pkgs.lean4 pkgs.lake pkgs.lean4Packages.lean-language-server ];
          shellHook = ''
            echo "Lean dev shell ready!"
          '';
        };
      }) // {
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
          specialArgs = { };
        };
      };
}
