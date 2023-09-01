{ config, pkgs, ... }:
{
 hardware.nvidia = { 
  modesetting.enable = true;
  powerManagement.enable = true;
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
  layout = "us";
  videoDrivers = [ "nvidia" ];
  # DISPLAY MANAGER
  displayManager = {
   lightdm = {
    enable = true;
   };
  };
 };
}
