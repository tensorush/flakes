{ ... }:

{
  home = {
    username = "jora";
    stateVersion = "23.05";
    homeDirectory = "/home/jora";
  };

  programs = {
    gpg.enable = true;
    home-manager.enable = true;
  };
}
