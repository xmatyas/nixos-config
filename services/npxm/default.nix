{ vars, ... }:
{
 virtualisation.oci-containers = {
  containers = {
   npxm = {
    image = "jc21/nginx-proxy-manager:latest";
    ports = ["80:80" "81:81" "443:443"];
    volumes = [
     "${vars.serviceConfigRoot}/npm/data:/data"
     "${vars.serviceConfigRoot}/npm/letsencrypt:/etc/letsencrypt"
    ];
   };
  };
 };
}
