{ config, pkgs, ... }:

{
  # Use systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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

  # Set fonts.
  fonts.fonts = [ pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; } ];

  # Specify console configuration.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable services. OpenSSH daemon.
  services = {
    # Enable QEMU agent.
    services.spice-vdagentd.enable = true;

    # Enable services. OpenSSH daemon.
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

  # Allow unfree and unsupported packages.
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  # List packages installed in system.
  environment.systemPackages = with pkgs; [
    fd
    gh
    jq
    bat
    fzf
    gdb
    git
    wget
    broot
    delta
    helix
    ninja
    procs
    bottom
    statix
    vscode
    zellij
    zoxide
    du-dust
    gnumake
    netdata
    nushell
    openssl
    ripgrep
    starship
    tealdeer
    valgrind
    wasmtime
    hyperfine
    difftastic
  ];

  # Define user accounts. Don't forget to set passwords with ‘passwd’.
  users.users.jora = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = [ "wheel" ];
  };

  # Don't require password for sudo.
  security.sudo.wheelNeedsPassword = false;

  # Specify Nix daemon configuration.
  nix = {
    # Enable unstable package channel.
    package = pkgs.nixUnstable;

    # Automate garbage collection.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Enable extra options.
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };

  # System state version - better not change it.
  system.stateVersion = "23.05";
}
