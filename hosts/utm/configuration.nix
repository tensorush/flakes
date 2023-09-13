{pkgs, ...}: {
  # System state version - better not change it.
  system.stateVersion = "23.05";

  # Set default user shell.
  users.defaultUserShell = pkgs.nushell;

  # Enable sound.
  sound.enable = true;

  # Configure security settings.
  security = {
    rtkit.enable = true;
    pam.services.swaylock = {};
    sudo.wheelNeedsPassword = false;
  };

  # Configure program settings.
  programs = {
    # Enable GPG agent.
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Enable Hyprland.
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Enable Waybar.
    waybar.enable = true;
  };

  # Define user accounts.
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = ["networkmanager" "wheel"];
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519  jora"
    # ];
  };

  # Configure boot settings.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # Use systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
  };

  # Configure networking settings.
  networking = {
    useDHCP = true;
    firewall.enable = false;
  };

  # Set time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_ADDRESS = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
    };
  };

  # Specify console configuration.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set fonts.
  fonts.packages = with pkgs; [
    fira-code
    font-awesome
    cascadia-code
    jetbrains-mono
  ];

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
  nixpkgs = {
    hostPlatform = "aarch64-linux";
    # Allow unfree and unsupported packages.
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
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

    # Configure X11 windowing system.
    xserver = {
      # Enable system.
      dpi = 100;
      enable = true;

      # Configure keyboard layouts.
      layout = "us, ru";
      xkbOptions = "eurosign:e, compose:menu, grp:alt_shift_toggle";

      # Configure desktop manager.
      desktopManager.cinnamon.enable = true;

      # # Enable Hyprland display manager.
      displayManager = {
        defaultSession = "hyprland";
        lightdm.enable = false;
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };

  environment.shells = with pkgs; [
    nushell
  ];

  # List packages installed in system.
  environment.systemPackages = with pkgs; [
    # Modern CLI program alternatives:

    # find
    fd
    # sed
    sd
    # cat
    bat
    # ls
    eza
    # make
    just
    # tree
    broot
    # ps
    procs
    # htop
    bottom
    # cd
    zoxide
    # du
    du-dust
    # flamegraph
    inferno
    # grep
    ripgrep
    # tldr
    tealdeer # outfieldr
    # diff
    difftastic

    # Other CLI programs:

    # GitHub
    gh
    # JSON processor
    jq
    # Fuzzy finder
    fzf
    # Version control system
    git
    # File manager
    nnn
    # Terminal emulator
    rio
    # File downloader
    wget
    # Git pager
    delta
    # Encryption tool
    # gnupg
    # Editor
    helix
    # Shell
    nushell
    # Shell prompt
    starship
    # Profiling tool suite
    valgrind
    # Nix linter
    alejandra
    # Benchmarking tool
    hyperfine

    # Wayland components:

    # Notification daemon
    mako
    # Wallpaper daemon
    swww
    # Wayland logout
    wlogout
    # Color picker
    hyprpicker
    # Widget system
    eww-wayland
    # App launcher
    rofi-wayland
    # Clipboard
    wl-clipboard
    # Lock screen
    swaylock-effects
    # Icon theme
    papirus-icon-theme
  ];
}
