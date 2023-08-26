{ inputs, lib, config, vars, pkgs, ... }:
let
 user = "xmatyas";
 hostname = "freyr";
in
{
 imports = [
   ./filesystems
   ../../home/freyr/hyprland.nix
 ];

 powerManagement = {
  enable = true;
  powertop.enable = true;
  cpuFreqGovernor = "performance";
 };

 networking = {
   hostName = "freyr";
 };
}
