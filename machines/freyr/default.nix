{ inputs, lib, config, vars, pkgs, ... }:
let
 hostname = "freyr";
in
{
 imports = [
   ./filesystems
   ../../modules/gui
   ../../dots/i3
   ../../dots/pipewire
   ../../dots/fonts
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
