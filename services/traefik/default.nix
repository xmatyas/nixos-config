{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/traefik"
 ];
 files = [
  "${vars.serviceConfigRoot}/traefik/acme.json"
 ];
in
{
 systemd.tmpfiles.rules = 
 map (x: "d ${x} 0775 share share - -") directories ++ map (x: "f ${x} 0600 share share - -") files;
 virtualisation.oci-containers = {
  containers = {
   traefik = {
    image = "traefik";
    autoStart = true;
    cmd = [
     "--api.insecure=true"
     "--providers.docker=true"
    ];
    ports = [
     "8080:8080"
     "80:80"
     "443:443"
    ];
    environmentFiles = [
     # config.age.secrets.cloudflareDnsApiCredentials.path
    ];
    volumes = [
     "/var/run/podman/podman.sock:/var/run/docker.sock:ro"
     "${vars.serviceConfigRoot}/traefik/acme.json:/acme.json"
    ];
   };
  };
 };
}
