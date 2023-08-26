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
     "2456:2456/udp"
     "2457:2457/udp"
    ];
    environment = {
     SERVER_NAME = "Helheim@Skadi";
     WORLD_NAME = "Helheim";
     TZ = vars.timeZone;
     PUID = "993";
     PGID = "993";
    };
    environmentFiles = [
     config.age.secrets.valheimServerEnv.path
    ];
    extraOptions = [
     "--cap-add=sys_nice"
     "--stop-timeout=120"
    ];
   };
  };
 };
}
