{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/homebridge"
  ];
in
{
 systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
 virtualisation.oci-containers = {
  containers = {
   homebridge = {
    image = "docker.io/homebridge/homebridge:latest";
    autoStart = true;
    volumes = [
     "${vars.serviceConfigRoot}/homebridge:/homebridge" 
    ];
    environment = {
     TZ = vars.timeZone;
     #PUID = "993";
     #GUID = "993";
    };
    ports = [
     "8581:8581"
    ];
    extraOptions = [
     "--network=host"
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.homebridge.rule=Host(`homebridge.${vars.domainName}`)"
     "-l=traefik.http.services.homebridge.loadbalancer.server.port=8581"
    ];
   };
  };
 };
}
