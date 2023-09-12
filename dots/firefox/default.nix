# https://github.com/notthebee/nix-config/blob/main/dots/firefox/default.nix
{ lib, pkgs, ... }:
let merge = lib.foldr (a: b: a // b) { };
in {
  programs.firefox = {
    enable = true;
    package = 
      if pkgs.stdenv.hostPlatform.isDarwin
        then pkgs.firefox-bin
      else pkgs.firefox;
    profiles = {
      default = {
        id = 0;
        name = "Default";
        isDefault = true;
        settings = merge [ 
        (import ./settings.nix) 
        (import ./browser-features.nix) 
        ];
	search = {
	  # ENABLE force, will cause home-manager service errors when backing up if not enabled.
	  force = true;
	  default = "DuckDuckGo";
	  engines = {
	   "Nix Packages" = {
            urls = [{
             template = "https://search.nixos.org/packages";
             params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
             ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
           };
  	   "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
           };
           "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
	};
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          multi-account-containers
	  ublock-origin
          bitwarden
	  istilldontcareaboutcookies
          privacy-redirect
          clearurls
          vimium
	  addy_io
        ];
        };
	"mozlz4.default" = {
	 id = 1;
	 name = "DefaultOld";
	 isDefault = false;
	};
      };
    };
  }
