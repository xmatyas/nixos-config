{ config, lib, ... }:

{
 users = {
  users = {
   share = {
    uid = 993;
    isSystemUser = true;
    group = "share";
   };
  };
  groups = {
   share = {
    gid = 993;
   };
  };
 };
 
 users.users.xmatyas.extraGroups = [ "share" ];
}
