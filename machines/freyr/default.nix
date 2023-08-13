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
    hostName = "freyr";
    };
  };
}
