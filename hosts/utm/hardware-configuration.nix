{modulesPath, ...}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod"];
    initrd.kernelModules = [];
    extraModulePackages = [];
    kernelModules = [];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6368e0b2-a701-41ce-9cd3-beaee0b63f89";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CD81-5023";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/c03fb5f7-d9f4-4b88-b1e6-317654a1f397";
    }
  ];
}
