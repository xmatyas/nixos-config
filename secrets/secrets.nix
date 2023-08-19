let
  xmatyas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3yWonbA/IvY4pzE+B/KKNj2jPV644HzQrRUCnEaRvp xmatyas@protonmail.com";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTRIIT3ekCvpFLs/XjN4fISiBDEmZ53OSc+U4yuuzG1 root@skadi";
  allKeys = [ xmatyas system ];
in
{
  "hashedUserPassword.age".publicKeys = allKeys;
  "cloudflareCredentials.age".publicKeys = allKeys;
  "valheimServerPass.age".publicKeys = allKeys;
}
