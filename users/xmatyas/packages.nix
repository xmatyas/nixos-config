{ pkgs, ... }:

{
 home.packages = [
  # DevOps
  pkgs.ansible
  pkgs.sshpass
 ];
}
