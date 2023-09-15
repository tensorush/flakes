{
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];

  system.stateVersion = "23.05";

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod"];
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [];
    extraModulePackages = [];
    kernelModules = [];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f4383962-697d-49fa-8b66-ecad910b3c9f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3DDB-0396";
    fsType = "vfat";
  };

  swapDevices = [{device = "/dev/disk/by-uuid/0f368cb9-2c85-4fb4-974f-697b3e1ceaf4";}];

  security.sudo.wheelNeedsPassword = false;

  networking = {
    hostName = "nixos";
    firewall.enable = false;
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  nix = {
    package = pkgs.nixUnstable;
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    hostPlatform = "aarch64-linux";
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
}
