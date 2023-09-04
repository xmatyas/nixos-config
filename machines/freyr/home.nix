{ pkgs, lib, inputs, ... }:
{
 nixpkgs.overlays = [
   inputs.nur.overlay
  ];
  imports = [
   ../../home/display
   ../../home/i3
   ../../home/kitty
  ../../dots/firefox
  ];

 home.packages = [
  # Mouse control
  pkgs.piper
  pkgs.libratbag
  # Messenger
  pkgs.signal-desktop
  # Bitwarden tools
  pkgs.bitwarden
  pkgs.bitwarden-cli
  pkgs.bitwarden-menu
  # Chatterino
  pkgs.chatterino2
  # Fonts
  pkgs.font-manager
  # Theme testing
  pkgs.themechanger
  pkgs.orchis-theme
  pkgs.numix-cursor-theme
  # Wine manager
  pkgs.bottles
  # Steam
  pkgs.steam
  pkgs.steam-tui
];
}
