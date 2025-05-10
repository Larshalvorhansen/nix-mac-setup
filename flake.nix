{
  description = "My macOS config with nix-darwin and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }: {
    darwinConfigurations."lhh-macbook" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      modules = [
        ./darwin/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.lhh = import ./home/lhh.nix {
            config = {};
            pkgs = import nixpkgs { system = "aarch64-darwin"; };
          };
        }
      ];
    };
  };
}
