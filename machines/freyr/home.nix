{ pkgs, lib, inputs, ... }:
{
 nixpkgs.overlays = [
  inputs.nur.overlay
 ];
 imports = [
  ../../home/display
  ../../home/kitty
  ../../dots/firefox
 ];
 programs.mangohud = {
  enable = true;
  enableSessionWide = true;
 };
 
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
  # Steam & games
  pkgs.steam
  pkgs.mangohud
  pkgs.gamemode
  pkgs.goverlay
  pkgs.prismlauncher
  # OBS
  pkgs.obs-studio
  # Obsidian
  pkgs.obsidian
  # Dev
  pkgs.vscodium
  # Torrent
  pkgs.deluge
  # Email
  pkgs.thunderbird
];
}
