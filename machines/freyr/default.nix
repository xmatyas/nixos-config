{ inputs, lib, config, vars, pkgs, ... }:
{

  imports = [
    ./filesystems
  ];

  powerManagement = {
   enable = true;
   powertop.enable = true;
   cpuFreqGovernor = "performance";
  };

  networking = {
    hostName = "freyr";
    };
  };
}
