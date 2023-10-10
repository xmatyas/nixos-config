let
  xmatyas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII8cwl2A+dHahEQtKvoK+5jLt5/teYqfCNVit1ZP3kDD xmatyas@mailbox.org";
  users = [ xmatyas ];
  
  skadi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTRIIT3ekCvpFLs/XjN4fISiBDEmZ53OSc+U4yuuzG1 root@skadi";
  freyr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPaKlJmDHbnSjsnwiwtpX49cMcJe8RKxtA7FIfutFW/ root@freyr";
  systems = [ skadi freyr ];

  # All public keys
  allKeys = users ++ systems;
in
{
  "hashedUserPassword.age".publicKeys = allKeys;
  "cloudflareCredentials.age".publicKeys = allKeys;
  "valheimServerEnv.age".publicKeys = allKeys;
  "obsidianLivesyncCredentials.age".publicKeys = allKeys; 
}
