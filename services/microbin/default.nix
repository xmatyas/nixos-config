{ config, vars, ... }:
let
directories = [
"${vars.serviceConfigRoot}/microbin"
];
  in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      microbin = {
        image = "danielszabo99/microbin:latest";
        autoStart = true;
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.microbin.rule=Host(`microbin.${vars.domainName}`)"
          "-l=traefik.http.services.microbin.loadbalancer.server.port=8081"
        ];
        volumes = [
          "${vars.serviceConfigRoot}/microbin:/app/microbin_data"
        ];
        environmentFiles = [
            config.age.secrets.microbinCredentials.path
            ./public.env
        ]; 
      };
    };
};
}
