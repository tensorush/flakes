{
  description = "My NixOS configuration flake for the ARM64 UTM VM.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.tensorush = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./system/configuration.nix
        ./system/hardware-configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jora = import ./users/jora/home.nix;
        }
      ];
    };
  };
}
