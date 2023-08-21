{ config, vars, ... }:
let
directories = [
	"${vars.serviceConfigRoot}/syncthing"
];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      syncthing = {
        image = "lscr.io/linuxserver/syncthing:latest";
        autoStart = true;
	ports = [
	 "8384:8384"
	 "22000:22000/tcp"
	 "22000:22000/udp"
	 "21027:21027/udp"
	];
        extraOptions = [
	  "--hostname=syncthing"
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.syncthing.rule=Host(`syncthing.${vars.domainName}`)"
          "-l=traefik.http.services.syncthing.loadbalancer.server.port=8384"
        ];
        volumes = [
          "${vars.serviceConfigRoot}/syncthing:/config"
        ];
        environment = {
          TZ = vars.timeZone;
          PUID = "993";
          PGID = "993";
        };
      };
    };
};
}
