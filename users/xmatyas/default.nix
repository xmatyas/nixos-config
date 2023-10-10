{ config, pkgs, lib, ... }:

let
  user = "xmatyas";
  homeDirectory = "/home/${user}";
in
{
  nix.settings.trusted-users = [ "${user}" ];
  
  programs.fish.enable = true;

  age.identityPaths = [ "${homeDirectory}/.ssh/id_25119" ];
  
  age.secrets.hashadUserPassword = {
    file = ../../secrets/hashedUserPassword.age;
  };
  
  users = {
    users = {
      ${user} = {
        shell = pkgs.fish;
        uid = 1000;
        isNormalUser = true;
        passwordFile = config.age.secrets.hashedUserPassword.path;
        extraGroups = [ "wheel" "users" "video" "podman" "gamemode" ];
        group = "${user}";
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII8cwl2A+dHahEQtKvoK+5jLt5/teYqfCNVit1ZP3kDD xmatyas@mailbox.org" ];
      };
    };
    groups = {
      ${user} = {
        gid = 1000;
      };
    };
  };
}
