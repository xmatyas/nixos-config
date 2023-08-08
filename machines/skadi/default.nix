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
    nameservers = [ "10.0.1.11" "1.1.1.1"];
    defaultGateway = {
     address = "10.0.0.1";
     interface = "enp0s31f6";
    };
    interfaces.enp0s31f6.ipv4 = {
     addresses = [{
      address = "10.0.0.10";
      prefixLength = 24;
     }];
     routes = [{
      address = "10.0.0.0";
      prefixLength = 24;
      via = "10.0.0.1";
    }];
    };
  };

  virtualisation.docker.storageDriver = "btrfs";
}
