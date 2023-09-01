{ pkgs, ... }:
{
 imports = [
  ./i3status-rust.nix
 ];
 xsession.windowManager.i3 = {
  enable = true;
  config = {
   fonts = {
    names = [ "IBM Plex Mono" "FiraCode"];
    style = "Regular";
    size = 11.0;
   };
   modifier = "Mod4";
   bars = [{
    position = "top";
    statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
   }];
  };
 };
}
