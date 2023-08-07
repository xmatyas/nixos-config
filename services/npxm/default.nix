{ vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/npxm"
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
    ];
   };
  };
 };
}
