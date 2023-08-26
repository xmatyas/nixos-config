{ vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/npxm"
  "${vars.serviceConfigRoot}/npxm/data"
  "${vars.serviceConfigRoot}/npxm/letsencrypt"
 ];
in
{
 systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
 virtualisation.oci-containers = {
  containers = {
   npxm = {
    autoStart = true;
    image = "jc21/nginx-proxy-manager:latest";
    ports = ["80:80" "81:81" "443:443"];
    volumes = [
     "${vars.serviceConfigRoot}/npxm/data:/data"
     "${vars.serviceConfigRoot}/npxm/letsencrypt:/etc/letsencrypt"
     "/var/run/podman/podman.sock:/var/run/docker.sock:ro"
    ];
    environment = {
     UID = "993";
     GID = "993";
    };
   };
  };
 };
}
