{ lib, inputs, ... }: 
{
  age.identityPaths = ["/persist/ssh/ssh_host_ed25519_key"];

  age.secrets.hashedUserPassword = lib.mkDefault {
	  file = ./hashedUserPassword.age;
  };
  age.secrets.cloudflareCredentials = lib.mkDefault {
	  file = ./cloudflareCredentials.age;
  };
  age.secrets.cloudflaredToken = lib.mkDefault {
	  file = ./cloudflaredToken.age;
  };
  age.secrets.valheimServerEnv = lib.mkDefault {
  	file = ./valheimServerEnv.age;
  };
  age.secrets.obsidianLivesyncCredentials = lib.mkDefault {
  	file = ./obsidianLivesyncCredentials.age;
  };
  age.secrets.flameCredentials = lib.mkDefault {
	  file = ./flameCredentials.age;
  };
  age.secrets.vaultwardenCredentials = lib.mkDefault {
  	file = ./vaultwardenCredentials.age;
  };
  age.secrets.microbinCredentials = lib.mkDefault {
	  file = ./microbinCredentials.age;
  };
  age.secrets.nextcloud-db-envs = lib.mkDefault {
	  file = ./nextcloud-db-envs.age;
  };
  age.secrets.tailscale = lib.mkDefault {
	  file = ./tailscale.age;
  };
}
