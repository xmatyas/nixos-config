{ inputs, lib, config, vars, pkgs, ... }:
let
 hostname = "freyr";
in
{
 imports = [
   ./filesystems
   ../../modules/gui
   ../../modules/i3
   ../../modules/pipewire
   ../../modules/fonts
 ];

 powerManagement = {
  enable = true;
  #powertop.enable = true;
  cpuFreqGovernor = "performance";
 };

 networking = {
   hostName = "freyr";
 }; 
}
