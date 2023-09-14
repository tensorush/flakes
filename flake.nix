{
  description = "My NixOS configuration flakes.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  }: {
    nixosConfigurations = let
      userName = "jora";
    in {
      nixosConfigurations = {
        utm = nixpkgs.lib.nixosSystem {
          modules = [./hosts/utm/configuration.nix ./hosts/utm/hardware-configuration.nix];
          specialArgs = {inherit userName;};
        };
      };

      homeConfigurations = {
        ${userName} = home-manager.lib.homeManagerConfiguration {
          modules = [./users/${userName}/home.nix];
          extraSpecialArgs = {inherit userName;};
        };
      };
    };
  };
}
