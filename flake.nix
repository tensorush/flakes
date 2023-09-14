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
      utm = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit userName;};
        modules = [
          ./hosts/utm/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userName} = {
                home = {
                  username = userName;
                  stateVersion = "23.05";
                  homeDirectory = "/home/${userName}";
                };
                programs.home-manager.enable = true;
              };
            };
          }
        ];
      };
    };
  };
}
