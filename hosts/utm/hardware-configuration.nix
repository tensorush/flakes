{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "usbhid" ];
    initrd.kernelModules = [ ];
    extraModulePackages = [ ];
    kernelModules = [ ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2ef8b6ee-e3c2-4193-a3bf-6344b9fc9bfa";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8FFD-CD99";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/dev/disk/by-uuid/6757f74b-37cb-4489-a90c-2b1ddd8045b6";
  }];
}
