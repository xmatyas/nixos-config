{ inputs, lib, config, vars, pkgs, ... }:
{
 imports = [
  ./filesystems
  ./tailscale.nix
  #./cloudflared.nix
  ../../users/share
 ];

 powerManagement = {
  enable = true;
  powertop.enable = true; 
  cpuFreqGovernor = "powersave";
 };

 networking = {
  hostName = "skadi";
  nameservers = [ 
   "10.0.0.254"
   "1.1.1.1"
  ];
  defaultGateway = {
   address = "10.0.0.1";
   interface = "enp0s31f6";
  };
  interfaces.enp0s31f6.ipv4 = {
   addresses = [{
    address = "10.0.0.10";
    prefixLength = 24;
   }];
   routes = [{
    address = "10.0.0.0";
    prefixLength = 24;
    via = "10.0.0.1";
    }];
   };
  };

  services.tailscale.enable = true;
  # systemd.services.glances = {
  #  after = [ "network.target" ];
  #  script = "${pkgs.glances}/bin/glances -w";
  #  wantedBy = [ "multi-user.target" ];
  #  serviceConfig = {
  #   Restart = "on-abort";
  #   RemainAfterExit = "yes";
  #  };
  # };

  networking.firewall.trustedInterfaces = [ "podman0" ];
  networking.firewall.allowedTCPPorts = [
   #61208 # glances
   #5201  # iperf
   #8123  # home-assistant
  ];
  networking.firewall.allowedUDPPorts = [
   #2456  # valheim server
   #2457  # valheim server
  ];
  environment.systemPackages = [
   pkgs.tailscale
   pkgs.tldr
   pkgs.iperf3
   pkgs.hd-idle
   pkgs.hddtemp
   pkgs.hdparm
   pkgs.iotop
   pkgs.smartmontools
   pkgs.ncdu
   pkgs.glances
   pkgs.bc
   pkgs.bat
   pkgs.helix
   pkgs.podman-tui
   pkgs.dive
  ];
}
