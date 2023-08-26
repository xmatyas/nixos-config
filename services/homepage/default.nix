{ vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/homepage"
  "${vars.serviceConfigRoot}/homepage/config"
 ];
in
{
 systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
 virtualisation.oci-containers = {
  containers = {
   homepage = {
    autoStart = true;
    image = "ghcr.io/benphelps/homepage:latest";
    ports = ["3000:3000"];
    volumes = [
     "${vars.serviceConfigRoot}/homepage/config:/app/config"
     "/run/podman/podman.sock:/var/run/docker.sock"
    ];
    environment = {
     PUID = "993";
     PGID = "993";
    };
    extraOptions = [
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.homebridge.rule=Host(`homepage.${vars.domainName}`)"
     "-l=traefik.http.services.homebridge.loadbalancer.server.port=3000"
    ];
   };
  };
 };
}
