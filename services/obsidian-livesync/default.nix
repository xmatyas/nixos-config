{ config, vars, ... }:
let
 directories = [
  "${vars.serviceConfigRoot}/obsidian-livesync"
 ];
 files = [
  "${vars.serviceConfigRoot}/obsidian-livesync/local.ini"
 ];
in
{
 systemd.tmpfiles.rules = 
 map (x: "d ${x} 0775 share share - -") directories ++ map (x: "C ${x} 0755 share share - -") files;
  
 virtualisation.oci-containers = {
  containers = {
   obsidian-livesync = {
    image = "docker.io/library/couchdb:3.3.3";
    
    volumes = [
     "${vars.serviceConfigRoot}/obsidian-livesync:/opt/couchdb/data"
     "${vars.serviceConfigRoot}/obsidian-livesync/local.ini:/opt/couchdb/etc/local.ini"
    ];

    # By default CouchDB uses UID 5984 for couchdb user.
    # environment = {};
    
    # Stored username and password in .age file
    environmentFiles = [
     config.age.secrets.obsidianLivesyncCredentials.path
    ];

    extraOptions = [
     "-l=traefik.enable=true"
     "-l=traefik.http.routers.obsidian-livesync.rule=Host(`obsidian.xmatyas.eu`)"
     "-l=traefik.http.routers.obsidian-livesync.entrypoints=websecure"
     "-l=traefik.http.routers.obsidian-livesync.service=obsidian-livesync"
     "-l=traefik.http.services.obsidian-livesync.loadbalancer.server.port=5984"
     "-l=traefik.http.routers.obsidian-livesync.tls=true"
     # Replace the string 'letsencrypt' with your own certificate resolver
     "-l=traefik.http.routers.obsidian-livesync.tls.certresolver=letsencrypt"
     "-l=traefik.http.routers.obsidian-livesync.middlewares=obsidiancors"
     # The part needed for CORS to work on Traefik 2.x starts here
     "-l=traefik.http.middlewares.obsidiancors.headers.accesscontrolallowmethods=GET,PUT,POST,HEAD,DELETE"
     "-l=traefik.http.middlewares.obsidiancors.headers.accesscontrolallowheaders=accept,authorization,content-type,origin,referer"
     "-l=traefik.http.middlewares.obsidiancors.headers.accesscontrolalloworiginlist=app://obsidian.md,capacitor://localhost,http://localhost"
     "-l=traefik.http.middlewares.obsidiancors.headers.accesscontrolmaxage=3600"
     "-l=traefik.http.middlewares.obsidiancors.headers.addvaryheader=true"
     "-l=traefik.http.middlewares.obsidiancors.headers.accessControlAllowCredentials=true"
    ];
   };
  };
 };
}
