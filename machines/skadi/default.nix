{ inputs, lib, config, vars, pkgs, ... }:
{

  imports = [
    ./filesystems
    ../../users/share
  ];

  powerManagement = {
   enable = true;
   # Disabled due to infinite alls to USB1 that cause endless loop. TODO: Fix powertop config so that USB1 doesn't get set to auto-managed, which causes the problem.
   powertop.enable = false;
  };

  networking = {
    hostName = "skadi";
    interfaces.enp0s31f6.ipv4.addresses = [{
	address = "10.0.0.10";
	prefixLength = 24;
    }];
  };

  virtualisation.docker.storageDriver = "btrfs";
}
