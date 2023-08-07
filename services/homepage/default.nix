{ vars, ... }:
{
 virtualisation.oci-containers = {
  containers = {
   homepage = {
    image = "ghcr.io/benphelps/homepage:latest";
    ports = ["3000:3000"];
    volumes = [
     "${vars.serviceConfigRoot}/homepage/config:/app/config"
    ];
   };
  };
 };
}
