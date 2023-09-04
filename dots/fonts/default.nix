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
   ibm-plex
   nerdfonts
   font-awesome
   # ( nerdfonts.override { fonts = 
   # [ "Hack" "FiraCode" "Meslo" "SourceCodePro" "Terminus" "Monoid" "Noto" "Iosevka" "ComicShannsMono" "JetBrainsMono" ]; 
   # })
  ];
  fontconfig = {
   defaultFonts = {
    serif = [ "IBM Plex Serif" ];
    sansSerif = [ "Cantarell" ];
    monospace = [ "IBM Plex Mono"];
    emoji = [ "Noto Color Emoji" ];
   };
  };
 };
}
