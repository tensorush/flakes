{ config, pkgs, ... }:

# Define custom fonts
let customFonts = pkgs.nerdfonts.override {
  fonts = [
    "CascadiaCode"
  ];
};

in
{
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
    firewall.enable = true;
    hostName = "tensorush";
    interfaces.enp0s10.useDHCP = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Specify console configuration.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = true;

  # Enable QEMU agent.
  services.spice-vdagentd.enable = true;

  # Configure X11 windowing system.
  services.xserver = {
    # Enable the system.
    enable = true;

    # Enable the Plasma 5 Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # Configure keyboard layouts.
    layout = "us, ru";
    xkbOptions = "eurosign:e, compose:menu, grp:alt_shift_toggle";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    fd
    bat
    fzf
    gdb
    git
    wget
    broot
    clang
    delta
    helix
    procs
    bottom
    rustup
    zellij
    zoxide
    du-dust
    git-hub
    netdata
    nushell
    ripgrep
    neofetch
    starship
    tealdeer
    valgrind
    wasmtime
    hyperfine
    difftastic
  ];

  # Set fonts.
  fonts.fonts = with pkgs; [ customFonts ];

  # Define user accounts. Don't forget to set passwords with ‘passwd’.
  users.users.jora = {
    isNormalUser = true;
    shell = pkgs.nushell;
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

  # Don't require password for sudo.
  security.sudo.wheelNeedsPassword = false;

  # System state version - better not change it.
  system.stateVersion = "23.05";
}
