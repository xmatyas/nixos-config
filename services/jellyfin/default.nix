{ config, vars, ... }:
let
directories = [
	"${vars.serviceConfigRoot}/jellyfin"
	"${vars.serviceConfigRoot}/jellyfin/test" 
];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      jellyfin = {
        image = "lscr.io/linuxserver/jellyfin";
        autoStart = true;
        extraOptions = [
          "--device=/dev/dri/renderD128:/dev/dri/renderD128"
          "--device=/dev/dri/card0:/dev/dri/card0"
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.jellyfin.rule=Host(`jellyfin.${vars.domainName}`)"
          "-l=traefik.http.services.jellyfin.loadbalancer.server.port=8096"
        ];
        volumes = [
         "${vars.serviceConfigRoot}/jellyfin:/config"
         "${vars.serviceConfigRoot}/jellyfin/test:/data/tvshows"
	];
        environment = {
          TZ = vars.timeZone;
          PUID = "993";
          PGID = "993";
          DOCKER_MODS = "linuxserver/mods:jellyfin-opencl-intel";
        };
      };
    };
};
}
