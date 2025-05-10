{
  description = "My macOS config with nix-darwin and Home Manager";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    # (Follow inputs as needed, ensuring home-manager follows nixpkgs, etc.)
  };
  outputs = { self, nixpkgs, darwin, home-manager, ... }: {
    darwinConfigurations.${config.hostname} = darwin.lib.darwinSystem {
      system = "x86_64-darwin";  # or "aarch64-darwin" for Apple Silicon
      modules = [
        ./darwin/configuration.nix            # system config (see below)
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.lhh = import ./home/lhh.nix;
        }
      ];
    };
  };
}
