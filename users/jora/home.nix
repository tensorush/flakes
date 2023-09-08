{ config, pkgs, ... }:

{
  home.username = "jora";
  home.stateVersion = "23.05";
  home.homeDirectory = "/home/jora";
  home.packages = with pkgs; [ brave ];

  programs.gpg.enable = true;
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
}
