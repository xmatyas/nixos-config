{ home-manager, pkgs, ... }:
{
 imports = [
  ../../home/display
  ../../home/i3
  ../../home/kitty
 ];

 home.packages = [
  pkgs.firefox
  # Mouse control
  pkgs.piper
  pkgs.libratbag
  # Messenger
  pkgs.signal-desktop
 ];
}
