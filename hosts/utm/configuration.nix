{
  pkgs,
  userName,
  ...
}: {
  # Import hardware configuration.
  imports = [./hardware-configuration.nix];

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

  # Configure user settings.
  users = {
    # Set default user shell.
    defaultUserShell = pkgs.nushell;

    # Define user accounts.
    users.${userName} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
      openssh.authorizedKeys.keys = ["ssh-ed25519 vfKbuN/HZrVmcS4nGBEH8WMcc4xMU5im+C7cfD2J/kI ${userName}"];
    };
  };

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

    # Set variables.
    variables = {
      NU_CONFIG_DIR = "/home/${userName}/dotfiles/shells/nushell";
      STARSHIP_CONFIG = "/home/${userName}/dotfiles/prompts/starship/starship.toml";
    };

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
      fzy
      # Version control system
      git
      # Terminal emulator
      foot
      # File downloader
      wget
      # File manager
      yazi
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
