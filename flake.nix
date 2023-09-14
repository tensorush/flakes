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
      USER = "jora";
    in {
      utm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";

        modules = [
          ./hosts/utm/configuration.nix
          ./hosts/utm/hardware-configuration.nix

          # Configure Home Manager settings.
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${USER} = {
                # Configure Home settings.
                home = {
                  username = USER;
                  stateVersion = "23.05";
                  homeDirectory = "/home/${USER}";
                };

                # Let Home Manager install and manage itself.
                programs.home-manager.enable = true;
              };
            };
          }
        ];
      };
    };
  };
}
