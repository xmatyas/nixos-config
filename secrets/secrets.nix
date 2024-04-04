let
  xmatyas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3yWonbA/IvY4pzE+B/KKNj2jPV644HzQrRUCnEaRvp xmatyas@protonmail.com";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICwkvcV7eaeV4t+FmNrysppUv3nENU+MVHMGu/yGDvWc root@skadi";
  allKeys = [ xmatyas system ];
in
{
  "hashedUserPassword.age".publicKeys = allKeys;
  "cloudflareCredentials.age".publicKeys = allKeys;
  "valheimServerEnv.age".publicKeys = allKeys;
  "obsidianLivesyncCredentials.age".publicKeys = allKeys; 
  "flameCredentials.age".publicKeys = allKeys;
  "vaultwardenCredentials.age".publicKeys = allKeys;
  "microbinCredentials.age".publicKeys = allKeys;
}
