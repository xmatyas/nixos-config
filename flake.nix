{
	inputs = {

		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		nur.url = "github:nix-community/nur";
		# Home-manager is a system for managing a user environment 
		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# Agenix is a command line tool for managing secrets in Nix configuration
		agenix = {
			url = "github:ryantm/agenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, nur, home-manager, agenix, ... }@inputs:

	{
		nixosConfigurations = {
			skadi = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = {
					inherit inputs;
					vars = import ./machines/skadi/vars.nix;
				};

				modules = [
					#Import the machines config and secrets
					./machines
					./machines/skadi
					./secrets
					agenix.nixosModules.default

					# Base config and modules
					./modules/podman
					
					# Services and applications
					#./services/deluge
					./services/traefik
					./services/vaultwarden
					#./services/jellyfin
					#./services/homeassistant
					#./services/obsidian-livesync
					#./services/valheim
					./services/flame
					./services/microbin
					# Nextcloud is unstable with SQLite and the linuxserver.io version, need to port it to a new database.
					./services/nextcloud

					# User specific configuration
					./users/xmatyas
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = false;
						home-manager.extraSpecialArgs = { inherit inputs; };
						home-manager.users.xmatyas.imports = [
						agenix.homeManagerModules.default
						./users/xmatyas/dots.nix
						];
						home-manager.backupFileExtension = "bak";
					}
				];
			};
			freyr = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = {
					inherit inputs;
					vars = ./machines/freyr/vars.nix;
				};
				modules = [
					# Imports machines config and secrets
					./machines
					./machines/freyr
					./secrets
					agenix.nixosModules.default

					# User specific configuration
					./users/xmatyas
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = false;
						home-manager.extraSpecialArgs = { inherit inputs; };
						home-manager.users.xmatyas.imports = [
						agenix.homeManagerModules.default
						./users/xmatyas/dots.nix
						];
						home-manager.backupFileExtension = "bak";
					}
				];
			};
		};
	};
}
