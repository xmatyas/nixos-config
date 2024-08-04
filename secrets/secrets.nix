let
  xmatyas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3yWonbA/IvY4pzE+B/KKNj2jPV644HzQrRUCnEaRvp xmatyas@protonmail.com";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICwkvcV7eaeV4t+FmNrysppUv3nENU+MVHMGu/yGDvWc root@skadi";
  system_new = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTRIIT3ekCvpFLs/XjN4fISiBDEmZ53OSc+U4yuuzG1 root@skadi";
  allKeys = [ xmatyas system system_new];
in
{
  "hashedUserPassword.age".publicKeys = allKeys;
  "cloudflareCredentials.age".publicKeys = allKeys;
  "cloudflaredToken.age".publicKeys = allKeys;
  "valheimServerEnv.age".publicKeys = allKeys;
  "obsidianLivesyncCredentials.age".publicKeys = allKeys; 
  "flameCredentials.age".publicKeys = allKeys;
  "vaultwardenCredentials.age".publicKeys = allKeys;
  "microbinCredentials.age".publicKeys = allKeys;
  "nextcloud-db-envs.age".publicKeys = allKeys;
  "tailscale.age".publicKeys = allKeys;
}
