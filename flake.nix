{
  description = "My NixOS configuration flakes.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    anyrun
  }: {
    nixosConfigurations = {
      utm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        system.packages = [ anyrun.packages.${system}.anyrun ];

        modules = [
          ./hosts/utm/configuration.nix
          ./hosts/utm/hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jora = import ./users/jora/home.nix;
          }
        ];
      };
    };
  };
}
