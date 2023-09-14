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

          # Set environment variables.
          environment.variables
          {
            XDG_CONFIG_HOME = "/home/${USER}/dotfiles";
            NU_CONFIG_DIR = "${XDG_CONFIG_HOME}/shells/nushell";
            STARSHIP_CONFIG = "${XDG_CONFIG_HOME}/prompts/starship/starship.toml";
          }

          # Configure user settings.
          users
          {
            # Set default user shell.
            defaultUserShell = pkgs.nushell;

            # Define user accounts.
            users.${USER} = {
              isNormalUser = true;
              extraGroups = ["networkmanager" "wheel"];
              openssh.authorizedKeys.keys = ["ssh-ed25519 vfKbuN/HZrVmcS4nGBEH8WMcc4xMU5im+C7cfD2J/kI ${USER}"];
            };
          }

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
