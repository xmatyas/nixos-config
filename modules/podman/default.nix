{ pkgs, config, ... }: 

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    #extraPackages = [ pkgs.btrfs ];
    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };
  virtualisation.oci-containers = {
    backend = "podman";
  };
  #networking.firewall.interfaces.podman0.allowedUPDPorts = [ 53 ];
}
