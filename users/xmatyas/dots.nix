{ inputs, lib, config, pkgs, ... }:
let
  user = "xmatyas";
  homeDirectory = "/home/${user}";
in
{
  nixpkgs = {
    #overlays = [];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  
  home = {
    username = "${user}";
    homeDirectory = "${homeDirectory}";
    stateVersion = "23.05";
  };
  programs.home-manager.enable = true;
  
  imports = [
    ./packages.nix
  ];
  
  programs.git = {
    enable = true;
    userName = "xmatyas";
    userEmail = "xmatyas@protonmail.com";
  };
}
