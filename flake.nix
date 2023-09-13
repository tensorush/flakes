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
      user = "jora";
    in {
      utm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";

        modules = [
          ./hosts/utm/configuration.nix
          ./hosts/utm/hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user} = {
                # Configure Home settings.
                home = {
                  username = user;
                  stateVersion = "23.05";
                  homeDirectory = "/home/${user}";
                };

                # Configure program settings.
                programs = {
                  # Let Home Manager install and manage itself.
                  home-manager.enable = true;

                  # Enable Rofi.
                  rofi = {
                    enable = true;
                    terminal = "${pkgs.rio}/bin/rio";
                    theme = ./configs/rofi/theme.rafi;
                  };
                };
              };
            };
          }
        ];
      };
    };
  };
}
