{ config, pkgs, ... }:
{
 hardware.nvidia = { 
  modesetting.enable = true;
  powerManagement.enable = true;
  #forceFullCompositionPipeline = true;
  open = false;
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
 };

 hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
 };

 services.xserver = {
  enable = true;
  videoDrivers = [ "nvidia" ];
  # DISPLAY MANAGER
  displayManager = {
   setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --off --output DP-0 --primary --rate 240.00 --mode 1920x1080";
   sddm = {
    enable = true;
   # greeters.gtk = {
   #  enable = true;
   #  theme = { 
   #   package = pkgs.orchis-theme;
   #   name = "Orchis-Grey-Dark-Compact";
   #  };
   #  iconTheme = {
   #   package = pkgs.tela-circle-icon-theme;
   #   name = "Tela-circle-black";
   #  };
   #  cursorTheme = {
   #   package = pkgs.numix-cursor-theme;
   #   name = "Numix-Cursor";
   #  };
   # };
   };
  };
 };
 programs.dconf.enable = true;
 qt.style = "gtk2";
 gtk.iconCache.enable = true;
}
