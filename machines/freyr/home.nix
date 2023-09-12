{ pkgs, lib, inputs, ... }:
{
 nixpkgs.overlays = [
   inputs.nur.overlay
  ];
  imports = [
   ../../home/display
   ../../home/i3
   ../../home/kitty
   ../../home/theme
   ../../dots/firefox
  ];
 
 home.packages = [
  # Mouse control
  pkgs.piper
  pkgs.libratbag
  # File manager
  pkgs.xfce.thunar
  pkgs.xfce.thunar-volman
  pkgs.xfce.thunar-archive-plugin
  pkgs.xfce.thunar-media-tags-plugin
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
  pkgs.steam-tui
  # OBS
  pkgs.obs-studio
  # Obsidian
  pkgs.obsidian
  # Cider
  pkgs.cider
];
}
