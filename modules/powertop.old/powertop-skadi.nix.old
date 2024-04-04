{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.powerManagement.powertop-skadi;
in {
  ###### interface

  options.powerManagement.powertop-skadi.enable = mkEnableOption (lib.mdDoc "powertop auto tuning on startup edited for faulty USB port");

  ###### implementation

  config = mkIf (cfg.enable) {
    systemd.services = {
      powertop = {
        wantedBy = [ "multi-user.target" ];
        after = [ "multi-user.target" ];
        description = "Powertop tunings";
        path = [ pkgs.kmod ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = "yes";
          ExecStart = "${pkgs.powertop}/bin/powertop --auto-tune";
	  ExecStartPost = pkgs.writeShellScript "powertop-skadi" ''
	   echo 'on' > '/sys/bus/usb/devices/usb1/power/control'
	   echo 'disabled' > '/sys/class/net/enp0s31f6/device/power/wakeup'
	   '';
        };
      };
    };
  };
}
