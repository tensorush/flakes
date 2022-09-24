{ config, pkgs, ... }:

{
  # Configure Home Manager settings.
  home.username = "zhora";
  home.homeDirectory = "/home/zhora";

  # Home Manager state version - better not change it.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Specify Home Manager packages.
  home.packages = with pkgs; [
    vlc
    gimp
    brave
    discord
    alacritty
    flameshot
    libreoffice
  ];
}
