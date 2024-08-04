{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ./disko.nix
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme""usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.initrd.services.lvm.enable = true;
  boot.initrd.systemd.enable = true;
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
  boot.kernel.sysctl = {
    "vm.overcommit_memory" = 1;
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
