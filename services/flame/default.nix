{ vars, config, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/flame"
 ];
in
{
 systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
 virtualisation.oci-containers = {
  containers = {
   flame = {
    log-driver="journald";
    autoStart = true;
    image = "docker.io/pawelmalak/flame:latest";
    ports = ["5005:5005"];
    volumes = [
     "${vars.serviceConfigRoot}/flame:/app/data"
     "/run/podman/podman.sock:/var/run/docker.sock"
    ];
    environmentFiles = [
     config.age.secrets.flameCredentials.path 
    ];
    extraOptions = [
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.flame.rule=Host(`flame.${vars.domainName}`)"
     "-l=traefik.http.services.flame.loadbalancer.server.port=5005"
    ];
   };
  };
 };
}
