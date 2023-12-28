{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/traefik"
  "${vars.serviceConfigRoot}/traefik/config"
 ];
 files = [
  "${vars.serviceConfigRoot}/traefik/config/dynamic.yml"
 ];
 filesRO = [
  "${vars.serviceConfigRoot}/traefik/acme.json"
 ];
in
{
 systemd.tmpfiles.rules = 
 map (x: "d ${x} 0775 share share - -") directories ++ map (x: "f ${x} 0775 share share - -") files ++ map (x: "f ${x} 0600 share share - -") filesRO;
 virtualisation.oci-containers = {
  containers = {
   traefik = {
    image = "traefik";
    autoStart = true;
    cmd = [
     "--api.insecure=true"
     "--providers.docker=true"
     "--providers.docker.exposedbydefault=false"
     # Dynamic conf file
     "--providers.file.filename=/etc/traefik/dynamic_conf.yml"
     # Certificate
     "--certificatesresolvers.letsencrypt.acme.dnschallenge=true"
     "--certificatesresolvers.letsencrypt.acme.dnschallenge.provider=cloudflare"
     "--certificatesresolvers.letsencrypt.acme.email=${vars.email}"
     "--certificatesresolvers.letsencrypt.acme.dnschallenge.resolvers=1.1.1.1:53,1.0.0.1:53"
     # HTTP
     "--entrypoints.web.address=:80"
     "--entrypoints.web.http.redirections.entrypoint.to=websecure"
     "--entrypoints.web.http.redirections.entrypoint.scheme=https"
     # HTTPS
     "--entrypoints.websecure.address=:443"
     "--entrypoints.websecure.http.tls=true"
     "--entrypoints.websecure.http.tls.certResolver=letsencrypt"
     "--entrypoints.websecure.http.tls.domains[0].main=${vars.domainName}"
     "--entrypoints.websecure.http.tls.domains[0].sans=*.${vars.domainName}"
    ];
    extraOptions = [
     # For docker use 'host.docker.internal', for podman use 'host.containers.internal'
     "--add-host=host.containers.internal:10.88.0.1"
     # Proxying Traefik itself
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.traefik.rule=Host(`proxy.${vars.domainName}`)"
     "-l=traefik.http.services.traefik.loadbalancer.server.port=8080"
    ];
    ports = [
     # HTTP
     "80:80"
     # HTTPS
     "443:443"
     # Web interface
     "8080:8080"
    ];
    environmentFiles = [
     config.age.secrets.cloudflareCredentials.path
    ];
    volumes = [
     "/var/run/podman/podman.sock:/var/run/docker.sock:ro"
     "${vars.serviceConfigRoot}/traefik/acme.json:/acme.json"
     "${vars.serviceConfigRoot}/traefik/config/dynamic.yml:/etc/traefik/dynamic_conf.yml"
    ];
   };
  };
 };
}
