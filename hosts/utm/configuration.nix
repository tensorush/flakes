{pkgs, ...}: {
  # System state version.
  system.stateVersion = "23.05";

  # Configure boot settings.
  boot = {
    # Install kernel packages.
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
    # Disable DHCP.
    useDHCP = false;

    # Disable Firewall.
    firewall.enable = false;
  };

  # Disable password for sudo.
  security.sudo.wheelNeedsPassword = false;

  # Set time zone.
  time.timeZone = "Europe/Moscow";

  # Specify font packages.
  fonts.packages = with pkgs; [
    cascadia-code
    noto-fonts-emoji
  ];

  # Configure console settings.
  console = {
    keyMap = "us";
    font = "Cascadia Code";
  };

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

  # Configure Nix settings.
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

  # Configure Nix Package settings.
  nixpkgs = {
    # Specify host platform.
    hostPlatform = "aarch64-linux";

    # Allow unfree and unsupported packages.
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };

  # Configure service settings.
  services = {
    # Enable OpenSSH daemon.
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
    };

    # Configure X11 windowing system.
    xserver = {
      # Enable system.
      dpi = 100;
      enable = true;

      # Configure keyboard layouts.
      layout = "us, ru";
      xkbOptions = "eurosign:e, compose:menu, grp:alt_shift_toggle";
    };
  };

  # Configure program settings.
  programs = {
    # Enable Waybar.
    waybar.enable = true;

    # Enable GPG agent.
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Configure environment settings.
  environment = {
    # Set shells.
    shells = [pkgs.nushell];

    # List packages installed in system.
    systemPackages = with pkgs; [
      # Wayland components:

      # Wallpaper daemon
      swww
      # Compositor
      river
      # Lock screen
      waylock
      # Clipboard
      wl-clipboard

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
      foot
      # File downloader
      wget
      # Git pager
      delta
      # Encryption tool
      gnupg
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
    ];
  };
}
