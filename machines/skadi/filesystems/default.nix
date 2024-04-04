{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ./disko.nix
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme""usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
   "pcie_aspm=force"
   "pcie_aspm.policy=powersave"
   "i915.enable_guc=2"
   "enable_fbc=1"
  ];
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # boot.loader = {
  #  systemd-boot.enable = true;
  #  efi.canTouchEfiVariables = true;
  # };

  # Trying to replace this with disko
  # fileSystems."/" =
  #   { device = "/dev/root_vg";
  #     fsType = "btrfs";
  #     options = [ "subvol=root" "compress=zstd" "noatime" ];
  #   };
  # fileSystems."/home" =
  #   { device = "/dev/root_vg";
  #     fsType = "btrfs";
  #     options = [ "subvol=home" "compress=zstd" "noatime" ];
  #   };
  # fileSystems."/nix" =
  #   { device = "/dev/root_vg";
  #     fsType = "btrfs";
  #     options = [ "subvol=nix" "compress=zstd" "noatime" ];
  #   };
  # fileSystems."/persist" =
  #   { device = "/dev/root_vg";
  #     fsType = "btrfs";
  #     options = [ "subvol=persist" "compress=zstd" "noatime" ];
  #     neededForBoot = true;
  #   };

  # fileSystems."/var/log" =
  #   { device = "/dev/root_vg";
  #     fsType = "btrfs";
  #     options = [ "subvol=log" "compress=zstd" "noatime" ];
  #     neededForBoot = true;
  #   };

  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/3B61-D930";
  #     fsType = "vfat";
  #   };

  # swapDevices =
  #   [ { device = "/dev/disk/by-uuid/a10c9143-48ec-4bdb-aa88-c137149d8c08"; }
  #   ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
