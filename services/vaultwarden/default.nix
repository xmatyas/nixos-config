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
    image = "vaultwarden/server:latest";
    autoStart = true;
    # extraOptions = [];
    volumes = [
     "${vars.serviceConfigRoot}/vaultwarden:/data"
    ];
    ports = [
     "8080:80"
     "3012:3012"
    ];
    environment = {
     DOMAIN = "https://vw.${vars.domainName}";
     WEBSOCKET_ENABLED = "true";
     UID = "993";
     GID = "993";
    };
   };
  };
 };
}
