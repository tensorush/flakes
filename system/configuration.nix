{ config, pkgs, ... }:

# Define custom fonts
let customFonts = pkgs.nerdfonts.override {
  fonts = [
    "JetBrainsMono"
  ];
};

in {
  # Specify hardware imports.
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Configure networking settings.
  networking = {
    useDHCP = false;
    hostName = "tensorush";
    interfaces.enp3s0.useDHCP = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Enable virtualisation.
  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Specify console configuration.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Configure X11 windowing system.
  services.xserver = {
    # Enable the system.
    enable = true;

    # Enable the Plasma 5 Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # Configure keymap in X11.
    layout = "us, ru";
    xkbOptions = "eurosign:e";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Specify videocard drivers.
  services.xserver.videoDrivers = [ "nvidia" ];
  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Shell
    fish

    # Browser
    brave

    # CLI utilities
    git
    ncdu
    wget
    bottom
    ffmpeg
    neofetch
    
    # Virtualisation
    docker
  ];

  # Set fonts.
  fonts.fonts = with pkgs; [
    customFonts
  ];

  # Configure SUID wrappers for programs.
  programs.fish.enable = true;

  # Define user accounts.
  # Don't forget to set passwords with ‘passwd’.
  users.users.zhora = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # Specify Nix daemon configuration.
  nix = {
    # Make it snow ;)
    package = pkgs.nixUnstable;

    # Automate `nix-store --optimise`.
    autoOptimiseStore = true;

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
  system.stateVersion = "21.11";
}
