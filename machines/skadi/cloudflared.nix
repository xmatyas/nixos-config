{ pkgs, config, vars, ... }:

{
  # Define user and group so it's created for cloudflared.
  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = { };
   
  services.cloudflared.enable = true;
  services.cloudflared.tunnels = {
    "skadi" = {
      credentialsFile = "${vars.serviceConfigRoot}/cloudflared/skadi.json";
      default = "http_status:404";
      ingress = {
        "*.xmatyas.eu" = {
          service = "http://localhost:80";
        };
      };
    };
  };
}
