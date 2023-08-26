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
    ports = [
     "8581:8581"
    ];
    environment = {
     TZ = vars.timeZone;
     PUID = "993";
     GUID = "993";
    };
    extraOptions = [
     #"--network=host"
     #This seems to fix host network not opening ports properly. Instead this opens just one port. #TODO: fix DNS resolving from inside container
     "--cap-add=CAP_NET_RAW,CAP_NET_BIND_SERVICE"
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.homebridge.rule=Host(`homebridge.${vars.domainName}`)"
     "-l=traefik.http.services.homebridge.loadbalancer.server.port=8581"
    ];
   };
  };
 };
}
