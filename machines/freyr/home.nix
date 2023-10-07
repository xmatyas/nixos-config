{ pkgs, lib, inputs, ... }:
{
 nixpkgs.overlays = [
  inputs.nur.overlay
 ];
 imports = [
  ../../home/display
  ../../home/kitty
  #../../home/theme
  ../../dots/firefox
 ];
# programs.mangohud = {
#  enable = true;
#  enableSessionWide = true;
# };

 home.packages = [
  # Mouse control
  pkgs.piper
  pkgs.libratbag
  # Messenger
  pkgs.signal-desktop
  pkgs.telegram-desktop
  # Bitwarden tools
  pkgs.bitwarden
  pkgs.bitwarden-cli
  pkgs.bitwarden-menu
  # Chatterino
  pkgs.chatterino2
  # Fonts
  pkgs.font-manager
  # Wine manager
  pkgs.bottles
  pkgs.winbox
  # Steam
  pkgs.steam
  pkgs.mangohud
  pkgs.gamemode
  # OBS
  pkgs.obs-studio
  # Obsidian
  pkgs.obsidian
  # Misc
  pkgs.plasma-theme-switcher
  pkgs.arc-kde-theme
  pkgs.adapta-kde-theme
  pkgs.qogir-kde
  pkgs.pitch-black
  # DevOps
  pkgs.ansible
  # Torrent
  pkgs.deluge
];
}
