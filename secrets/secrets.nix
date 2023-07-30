let
  xmatyas = "ssh-ed25519 ";
  system = "ssh-ed25519 ";
  allKeys = [ xmatyas skadi ];
in
{
  "".publicKeys = allKeys;
}