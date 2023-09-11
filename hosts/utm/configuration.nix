{pkgs, ...}: {
  # System state version - better not change it.
  system.stateVersion = "23.05";

  # Set default user shell.
  users.defaultUserShell = pkgs.nushell;

  # Enable sound.
  sound.enable = true;

  # Configure security settings.
  security = {
    # rtkit.enable = true;
    # pam.services.swaylock = { };
    sudo.wheelNeedsPassword = false;
  };

  # Configure program settings.
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    # hyprland = {
    #   enable = true;
    #   xwayland = {
    #     enable = true;
    #     hidpi = true;
    #   };
    # };
  };

  # Define user accounts. Don't forget to set passwords with ‘passwd’.
  users.users.jora = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = ["networkmanager" "wheel"];
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519  jora"
    # ];
  };

  # Use systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
  };

  # Configure networking settings.
  networking = {
    useDHCP = true;
    #   firewall.enable = false;
    #   hostName = "utm";
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
  fonts.fonts = [pkgs.nerdfonts.override {fonts = ["CascadiaCode"];}];

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

  # Specify host platform.
  nixpkgs.hostPlatform = "aarch64-linux";

  # Allow unfree and unsupported packages.
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  # Enable services.
  services = {
    # Enable OpenSSH daemon.
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
    };

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      alsa.support32Bit = true;
    };

    # Enable XDG Wayland portal.
    # xdg.portal = {
    #   enable = true;
    #   wlr.enable = true;
    #   extraPortals = with pkgs; [
    #     xdg-desktop-portal-gtk
    #   ];
    # };

    # Configure X11 windowing system.
    xserver = {
      # Enable system.
      dpi = 100;
      enable = true;

      # Configure keyboard layouts.
      layout = "us, ru";
      xkbOptions = "eurosign:e, compose:menu, grp:alt_shift_toggle";

      # Configure desktop manager.
      desktopManager.plasma5.enable = true;
      # desktopManager.xterm.enable = false;

      # # Enable Hyprland display manager.
      displayManager.sddm.enable = true;
      # displayManager = {
      #   defaultSession = "hyprland";
      #   lightdm.enable = false;
      #   gdm = {
      #     enable = true;
      #     wayland = true;
      #   };
      # };
    };
  };

  environment.shells = with pkgs; [
    nushell
  ];

  # List packages installed in system.
  environment.systemPackages = with pkgs; [
    fd
    gh
    jq
    sd
    bat
    eza
    fzf
    git
    lsd
    # sww
    curl
    just
    # mako
    wget
    broot
    delta
    gnupg
    helix
    procs
    unzip
    bottom
    # swaybg
    vscode
    # waybar
    zoxide
    du-dust
    netdata
    nushell
    openssl
    ripgrep
    wezterm
    # wlogout
    starship
    # swayidle
    tealdeer
    valgrind
    alejandra
    hyperfine
    difftastic
    # hyprpicker
    # rofi-wayland
    # wl-clipboard
    # swaylock-effects
    # papirus-icon-theme
    # rofi-wayland-unwrapped
  ];
}
