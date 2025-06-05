{
  description = "Main configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
      nixosConfigurations = {
        JOYOUS-MACHINE-EXCELLENCE = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./host/JOYOUS-MACHINE-EXCELLENCE/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "backup";
                users.wayfarer = import ./home/wayfarer.nix;
              };
            }
          ];
        };
      };
    };
}

