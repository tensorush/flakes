{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.tensorush = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
        ];
      };

      homeManagerConfigurations.jora = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "jora";
        stateVersion = "23.05";
        homeDirectory = "/home/jora";
        configuration = {
          imports = [
            ./users/jora/home.nix
          ];
        };
      };
    };
}
