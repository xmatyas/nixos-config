{ config, lib, ... }:

{
 users = {
  users = {
   share = {
    uid = 999;
    isSystemUser = true;
    group = "share";
   };
  };
  groups = {
   share = {
    gid = 999;
   };
  };
 };
 
 users.users.xmatyas.extraGroups = [ "share" ];
}
