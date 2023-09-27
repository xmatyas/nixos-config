{ config, pkgs, ... }:
{
 services.xserver = {
  enable = true;
  desktopManager = {
   xterm.enable = false;
  };
  
  displayManager = {
   defaultSession = "plasma";
  };

  desktopManager.plasma5 = {
   enable = true;
  };
 };
 environment.plasma5 = {
  excludePackages = [
    pkgs.elisa
    pkgs.gwenview
    pkgs.okular
    pkgs.oxygen
    pkgs.khelpcenter
    pkgs.konsole
    pkgs.plasma-browser-integration
   ];
 };
}
