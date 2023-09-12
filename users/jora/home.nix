{...}: {
  # Configure Home settings.
  home = {
    username = "jora";
    stateVersion = "23.05";
    homeDirectory = "/home/jora";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
