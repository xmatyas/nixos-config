##########################################################################
# Remember to edit configuration.yaml to allow traefik to redirect	 #
# http:									 #
#  use_x_forwarded_for: true						 #
#  trusted_proxies:							 #
#    -  10.88.0.0/16 or the corresponding docker/podman internal network #
##########################################################################

{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/home-assistant"
  ];
in
{
 systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
 virtualisation.oci-containers = {
  containers = {
   homeassistant = {
    image = "docker.io/homeassistant/home-assistant:2024.5.5";
    autoStart = true;
    volumes = [
     "${vars.serviceConfigRoot}/home-assistant:/config" 
    ];
    # ports = [
    #  "8123:8123"
    # ];
    environment = {
     TZ = vars.timeZone;
     PUID = "993";
     GUID = "993";
    };
    extraOptions = [
     # "--network=host"
     # Testing homeassistant being within podman network
     # "--cap-add=CAP_NET_RAW,CAP_NET_BIND_SERVICE"
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.homeassistant.rule=Host(`ha.${vars.domainName}`)"
     "-l=traefik.http.services.homeassistant.loadbalancer.server.port=8123"
    ];
   };
  };
 };
}
