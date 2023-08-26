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
    image = "ghcr.io/home-assistant/home-assistant:latest";
    autoStart = true;
    volumes = [
     "${vars.serviceConfigRoot}/home-assistant:/config" 
    ];
    environment = {
     TZ = vars.timeZone;
     PUID = "993";
     GUID = "993";
    };
    extraOptions = [
     #"--network=host"
     #TODO: fix DNS resolving. Host mode has some port opening conflicts.
     "--cap-add=CAP_NET_RAW,CAP_NET_BIND_SERVICE"
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.homeassistant.rule=Host(`ha.${vars.domainName}`)"
     "-l=traefik.http.services.homeassistant.loadbalancer.server.port=8123"
    ];
   };
  };
 };
}
