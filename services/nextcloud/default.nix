{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/nextcloud"
  "${vars.serviceConfigRoot}/nextcloud/config"
  "${vars.serviceConfigRoot}/nextcloud/data"
 ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
    virtualisation.oci-containers = {
      containers = {
        nextcloud = {
          image = "lscr.io/linuxserver/nextcloud:latest";
          #image = "docker.io/library/nextcloud:latest";
	  autoStart = true;
          ports = [
            #"8443:443"
          ];
          extraOptions = [
            "-l=traefik.enable=true"
            "-l=traefik.http.routers.nextcloud.rule=Host(`nextcloud.${vars.domainName}`)"
            "-l=traefik.http.services.nextcloud.loadbalancer.server.port=443"
	    "-l=traefik.http.services.nextcloud.loadbalancer.serverstransport=ignorecert@file"
	    "-l=traefik.http.services.nextcloud.loadbalancer.server.scheme=https"
	  ];
          volumes = [
            "${vars.serviceConfigRoot}/nextcloud/config:/config"
            "${vars.serviceConfigRoot}/nextcloud/data:/data"
          ];
          environment = {
            TZ = "${vars.timeZone}";
            PUID = "993";
            PGID = "993";
          };
          environmentFiles = [
            ./public.env
          ]; 
        };
      };
    };
}
