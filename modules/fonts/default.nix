{ pkgs, ... }:
{
 fonts = {
  enableDefaultFonts = true;
  fonts = with pkgs; [
   noto-fonts
   liberation_ttf
   nerdfonts
  ];
  fontconfig = {
   defaultFonts = {
    serif = [ "IBM Plex" "Ubuntu" ];
    sansSerif = [ "IBM Plex" "Ubuntu" ];
    monospace = [ "IBM Plex" "Ubuntu" ];
   };
  };
 };
}
