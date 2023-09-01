{ config, pkgs, ... }:
{
 security.rtkit.enable = true;
 services.pipewire = {
  enable = true;
  audio.enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  wireplumber.enable = true;
 };
 environment.systemPackages = [
  pkgs.pipewire
  pkgs.wireplumber
  pkgs.helvum
  pkgs.pavucontrol
  pkgs.ncpamixer
 ];
}
