{...}: {
  # Configure Home settings.
  home = {
    username = "jora";
    stateVersion = "23.05";
    homeDirectory = "/home/jora";
  };

  # Configure program settings.
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # Enable GPG agent.
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Enable Rofi.
    rofi = {
      enable = true;
      terminal = "${pkgs.rio}/bin/rio";
      theme = ../../configs/rofi/theme.rafi;
    };
  }
}
