{ pkgs, ... }:
let
 user = "xmatyas";
in
{
 services.xserver.enable = true;

 programs.hyprland = {
  enable = true;
  nvidiaPatches = true;
  xwayland.enable = true;
 };

 environment.sessionVariables = {
  # Invisible cursor
  WRL_NO_HARDWARE_CURSORS = "1";
  # Hint electron apps to use wayland
  NIXOS_OZONE_WL = "1";
 };

 hardware = {
  opengl.enable = true;
  nvidia.modesetting.enable = true;
 };
 xdg.portal = {
  enable = true;
  wlr.enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
 };
 
 # Display manager
 services.xserver.displayManager.gdm = {
  enable = true;
  wayland = true;
 };
}
