{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/nextcloud"
  "${vars.serviceConfigRoot}/nextcloud/config"
  "${vars.serviceConfigRoot}/nextcloud/data"
  "${vars.serviceConfigRoot}/nextcloud/db"
  "${vars.serviceConfigRoot}/nextcloud/db/data"
  "${vars.serviceConfigRoot}/nextcloud/redis"
  "${vars.serviceConfigRoot}/nextcloud/redis/data"
];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  systemd.services = {
    podman-nextcloud-db ={
      requires = [
        "podman-nextcloud.service"
      ];
      after = [
        "podman-nextcloud.service"
      ];
    };
    podman-nextcloud-redis ={
      requires = [
        "podman-nextcloud.service"
      ];
      after = [
        "podman-nextcloud.service"
      ];
    };
   };
  virtualisation.oci-containers = {
      containers = {
        nextcloud = {
          image = "lscr.io/linuxserver/nextcloud:29.0.4";
          autoStart = true;
          extraOptions = [
            #####################################################################################
            #                               Traefik settings                                    #
            #####################################################################################
            "-l=traefik.enable=true"
            "-l=traefik.http.routers.nextcloud.rule=Host(`cloud.${vars.domainName}`)"
            "-l=traefik.http.services.nextcloud.loadbalancer.server.port=443"
	          "-l=traefik.http.services.nextcloud.loadbalancer.serverstransport=ignorecert@file"
	          "-l=traefik.http.services.nextcloud.loadbalancer.server.scheme=https"
            #####################################################################################
            #                               Caldav redirect regex                               #
            #####################################################################################
            "-l=traefik.http.routers.nextcloud.middlewares=nextcloud-caldav@docker"
            "-l=traefik.http.middlewares.nextcloud-caldav.redirectregex.permanent=true"
            "-l=traefik.http.middlewares.nextcloud-caldav.redirectregex.regex='https://(.*)/.well-known/(?:card|cal)dav'"
            "-l=traefik.http.middlewares.nextcloud-caldav.redirectregex.replacement='https://$${1}/remote.php/dav'"
            #####################################################################################
            #                        Transport security header rewrite                          #
            #####################################################################################
            "-l=traefik.http.middlewares.nextcloud-headers.headers.customresponseheaders.Strict-Transport-Security=max-age=15552000; includeSubDomains; preload"
            "-l=traefik.http.middlewares.nextcloud-headers.headers.customrequestheaders.X-Forwarded-Proto=https"
            "-l=traefik.http.middlewares.nextcloud-headers.headers.customrequestheaders.X-Forwarded-Ssl=on"
            "-l=traefik.http.routers.nextcloud.middlewares=nextcloud-headers"                  
          ];
          volumes = [
            "${vars.serviceConfigRoot}/nextcloud/config:/config"
            "${vars.serviceConfigRoot}/nextcloud/data:/data"
          ];
          environment = {
            TZ = "${vars.timeZone}";
            PUID = "993";
            PGID = "993";
            REDIS_HOST = "nextcloud-redis";          
          };
          environmentFiles = [
            ./public.env
          ];
        };
        nextcloud-db = {
          image = "docker.io/library/postgres:16.3";
          ports = [
            "5432:5432"
          ];
          extraOptions = [
          #####################################################################################
          #                                Network option                                     #
          #####################################################################################
            "--network=container:nextcloud"
          ];
          volumes = [
            "${vars.serviceConfigRoot}/nextcloud/db/data:/var/lib/postgresql/data"
          ];
          environment = {
            TZ = "${vars.timeZone}";
            PUID = "993";
            PGID = "993";
         };
          environmentFiles = [
            config.age.secrets.nextcloud-db-envs.path
          ];
        };
        nextcloud-redis = {
          image = "docker.io/library/redis:7.2.5-alpine";
          volumes = [
            "${vars.serviceConfigRoot}/nextcloud/redis/data:/data"
          ];
          extraOptions = [
          #####################################################################################
          #                                Network option                                     #
          #####################################################################################
            "--network=container:nextcloud"
          ];
          environment = {
            TZ = "${vars.timeZone}";
            PUID = "993";
            PGID = "993";    
          };
        };
      };
    };
}
