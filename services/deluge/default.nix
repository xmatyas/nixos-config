{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/deluge"
  "${vars.serviceConfigRoot}/deluge/config"
  "${vars.serviceConfigRoot}/deluge/completed"
 ];
in
{
 systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
 virtualisation.oci-containers = {
  containers = {
   deluge = {
    image = "linuxserver/deluge:latest";
    autoStart = true;
    volumes = [
     "${vars.serviceConfigRoot}/deluge/config:/config"
     "${vars.serviceConfigRoot}/deluge/completed:/data/completed"
    ];
    ports = [
     "8112:8112"
     "6881:6881"
    ];
    environment = {
     TZ = vars.timeZone;
     PUID = "993";
     GUID = "993";
    };
    extraOptions = [
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.deluge.rule=Host(`deluge.${vars.domainName}`)"
     "-l=traefik.http.services.deluge.loadbalancer.server.port=8112"
    ];
   };
  };
 };
}
