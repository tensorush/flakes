{userName, ...}: {
  # Configure Home settings.
  home = {
    username = ${userName};
    stateVersion = "23.05";
    homeDirectory = "/home/${userName}";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
