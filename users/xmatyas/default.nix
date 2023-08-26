{ config, pkgs, lib, ... }:

let
  user = "xmatyas";
  homeDirectory = "/home/${user}";
in
{
  nix.settings.trusted-users = [ "${user}" ];
  
  programs.fish.enable = true;

  #age.identifyPaths = [ "${homeDirectory}/.ssh/id_25119" ];
  #age.secrets.hashadUserPassword = {
  #  file = ../../secrets/hashedUserPassword.age;
  #};
  
  users = {
    users = {
      ${user} = {
        shell = pkgs.fish;
        uid = 1000;
        isNormalUser = true;
        #passwordfile = config.age.secrets.hashedUserPassword.path;
        extraGroups = [ "wheel" "users" "video" "podman" ];
        group = "${user}";
        #openssh.authorizedKeys.keys = [ "ssh-ed25119 xy" ]
      };
    };
    groups = {
      ${user} = {
        gid = 1000;
      };
    };
  };
}
