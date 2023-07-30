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
  };

  virtualisation.docker.storageDriver = "btrfs";
}
