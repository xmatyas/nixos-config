{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/valheim-server"
  "${vars.serviceConfigRoot}/valheim-server/config"
  "${vars.serviceConfigRoot}/valheim-server/data"
 ];
in
{
 systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
 virtualisation.oci-containers = {
  containers = {
   valheim = {
    image = "docker.io/lloesche/valheim-server:latest";
    autoStart = true;
    volumes = [
     "${vars.serviceConfigRoot}/valheim-server/config:/config"
     "${vars.serviceConfigRoot}/valheim-server/data:/opt/valheim"
    ];
    ports = [
     "2456-2457:2456-2457/udp"
    ];
    environment = {
     SERVER_NAME = "valheim.skadi";
     WORLD_NAME = "Helheim";
     SERVER_PUBLIC = "false";
     SERVER_PASS = "${config.age.secrets.valheimServerPass.path}";
     TZ = vars.timeZone;
     PUID = "993";
     PGID = "993";
    };
    extraOptions = [
     "--cap-add=sys_nice"
     "-l=traefik.enable=true"
     "-l=traefik.udp.routers.valheim.rule=(`valheim.skadi`)"
     "-l=traefik.udp.services.valheim.loadbalancer.server.port=2456"
    ];
   };
  };
 };
}
