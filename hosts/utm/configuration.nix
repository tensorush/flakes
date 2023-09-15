{
  pkgs,
  userName,
  ...
}: {
  imports = [./hardware-configuration.nix];

  time.timeZone = "Europe/Moscow";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_NAME = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
    };
  };

  fonts.packages = with pkgs; [
    cascadia-code
    noto-fonts-emoji
  ];

  users = {
    defaultUserShell = pkgs.nushell;
    users.${userName} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
    };
    xserver = {
      enable = true;
      layout = "us, ru";
      desktopManager.lxqt.enable = true;
      displayManager.lightdm.enable = true;
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = userName;
      xkbOptions = "eurosign:e, compose:menu, grp:alt_shift_toggle";
    };
  };

  programs = {
    nm-applet.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment = {
    shells = [pkgs.nushell];
    systemPackages = with pkgs; [
      # GUI programs:

      # Editor
      vscode
      # Browser
      brave

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
      # File downloader
      wget
      # File manager
      yazi
      # Git pager
      delta
      # Editor
      helix
      # Shell
      nushell
      # Shell prompt
      starship
      # Profiling tool suite
      valgrind
      # Terminal emulator
      alacritty
      # Nix linter
      alejandra
      # Benchmarking tool
      hyperfine
    ];
  };
}
