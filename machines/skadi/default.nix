{ inputs, lib, config, vars, pkgs, ... }:
{

  imports = [
    ./filesystems
  ];

  powerManagement = {
  	enable = true;
	powertop.enable = true;
  };

  networking = {
    hostName = "skadi";
    interfaces.enp0s31f6.ipv4.addresses = [{
	address = "10.0.1.10";
	prefixLength = 24;
    }];
  };

  virtualisation.docker.storageDriver = "btrfs";
}
