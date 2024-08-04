{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/vaultwarden"
 ];
in
{
 systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
 virtualisation.oci-containers = {
  containers = {
   vaultwarden = {
    image = "ghcr.io/dani-garcia/vaultwarden:1.30.5-alpine";
    extraOptions = [
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.vaultwarden.rule=Host(`vault.${vars.domainName}`)"
     "-l=traefik.http.services.vaultwarden.loadbalancer.server.port=80"
    ];
    volumes = [
     "${vars.serviceConfigRoot}/vaultwarden:/data"
    ];
    environment = {
     DOMAIN = "https://vault.${vars.domainName}";
    };
    environmentFiles = [
	   config.age.secrets.vaultwardenCredentials.path
	   ./public.env
    ];
   };
  };
 };
}
