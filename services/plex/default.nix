{ config, vars, ... }:
let
directories = [
	"${vars.serviceConfigRoot}/plex"
	"${vars.serviceConfigRoot}/plex/music"
  "${vars.serviceConfigRoot}/plex/movies"
  "${vars.serviceConfigRoot}/plex/series" 
];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      plex = {
        image = "lscr.io/linuxserver/plex:1.40.3";
        autoStart = true;
        ports = [
        #   "32400:32400"
        #   "1900:1900/udp"
        #   "5353:5353/udp"
        #   "8324:8324"
        #   "32410:32410/udp"
        #   "32412:32412/udp"
        #   "32413:32413/udp"
        #   "32414:32414/udp"
        #   "32469:32469"  
        ];
        extraOptions = [
          "--device=/dev/dri:/dev/dri"
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.plex.rule=Host(`plex.${vars.domainName}`)"
          "-l=traefik.http.services.plex.loadbalancer.server.port=32400"
        ];
        volumes = [
          "${vars.serviceConfigRoot}/plex:/config"
          "${vars.serviceConfigRoot}/plex/series:/series"
        ];
        environment = {
          TZ = vars.timeZone;
          PUID = "993";
          PGID = "993";
          VERSION = "docker";
        };
      };
    };
};
}
