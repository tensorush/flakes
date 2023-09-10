{ pkgs, ... }:

{
  # System state version - better not change it.
  system.stateVersion = "23.05";

  # Don't require password for sudo.
  security.sudo.wheelNeedsPassword = false;

  # Define user accounts. Don't forget to set passwords with ‘passwd’.
  users.users.jora = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519  jora"
    ];
  };

  # Use systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
  };

  # Configure networking settings.
  networking = {
    useDHCP = false;
    hostName = "tensorush";
    firewall.enable = false;
    interfaces.enp0s10.useDHCP = true;
  };

  # Set time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Specify console configuration.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set fonts.
  fonts.fonts = [ pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; } ];

  # Specify Nix daemon configuration.
  nix = {
    # Enable unstable package channel.
    package = pkgs.nixUnstable;

    # Optimize storage automatically.
    settings.auto-optimise-store = true;

    # Automate garbage collection.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };

    # Enable extra options.
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };

  # Allow unfree and unsupported packages.
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  # Enable services.
  services = {
    # Enable QEMU agent.
    services.spice-vdagentd.enable = true;

    # Enable OpenSSH daemon.
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
    };

    # Configure X11 windowing System.
    xserver = {
      # Enable system.
      dpi = 220;
      enable = true;

      # Configure keyboard layouts.
      layout = "us, ru";
      xkbOptions = "eurosign:e, compose:menu, grp:alt_shift_toggle";
    };
  };

  # List packages installed in system.
  environment.systemPackages = with pkgs; [
    fd
    gh
    jq
    bat
    eza
    fzf
    git
    curl
    just
    wget
    broot
    delta
    gnupg
    helix
    procs
    unzip
    bottom
    vscode
    waybar
    zellij
    zoxide
    du-dust
    netdata
    nushell
    openssl
    ripgrep
    starship
    tealdeer
    valgrind
    alejandra
    hyperfine
    difftastic
  ];
}
