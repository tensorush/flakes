{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:

  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  in {
    nixosConfigurations.tensorush = lib.nixosSystem {
      inherit system;
      modules = [
        ./system/configuration.nix
      ];
    };

    homeManagerConfigurations.zhora = home-manager.lib.homeManagerConfiguration {
      inherit system pkgs;
      username = "zhora";
      stateVersion = "21.11";
      homeDirectory = "/home/zhora";
      configuration = {
        imports = [
          ./users/zhora/home.nix
        ];
      };
    };
  };
}
