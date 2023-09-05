{ config, pkgs, ... }:
{
 services.xserver = {
  enable =true;
  desktopManager = {
   xterm.enable = false;
  };

  displayManager = {
   defaultSession = "none+i3";
  };

  windowManager.i3 = {
   enable = true;
   extraPackages = [
    pkgs.dmenu
    pkgs.i3status-rust
    pkgs.i3lock
    pkgs.i3wsr
    pkgs.rofi
    pkgs.dunst
    pkgs.picom
   ];
  };
 };

 services.picom = {
  enable = true;
  shadow = true;
  inactiveOpacity = 1;
 };
}
