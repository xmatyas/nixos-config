{ pkgs, ... }:
{
 fonts = {
  enableDefaultFonts = true;
  fontDir.enable = true;
  fonts = with pkgs; [
   noto-fonts
   liberation_ttf
   ubuntu_font_family
   cantarell-fonts
   #ibm-plex
   font-awesome
   ( nerdfonts.override { fonts = 
   [ "FiraCode" "Noto" "Iosevka" "ComicShannsMono" "IBMPlexMono" "CascadiaCode" ]; 
   })
  ];
  fontconfig = {
   defaultFonts = {
    serif = [ "Noto Serif" ];
    sansSerif = [ "Noto Sans" ];
    monospace = [ "IBM Plex Mono"];
    emoji = [ "Noto Color Emoji" ];
   };
  };
 };
}
