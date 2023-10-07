{ inputs, lib, config, vars, pkgs, ... }:
let
 hostname = "freyr";
in
{
 imports = [
   ./filesystems
   ../../modules/gui
   ../../dots/kde
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
 i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_COLLATE = "de_DE.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
 };
}
