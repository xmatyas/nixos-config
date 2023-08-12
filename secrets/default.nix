{ lib, inputs, ... }: 
{
  age.identityPaths = ["/persist/ssh/ssh_host_ed25519_key"];

  age.secrets.hashedUserPassword = lib.mkDefault {
    file = ./hashedUserPassword.age;
  };
  age.secrets.cloudflareCredentials = lib.mkDefault {
      file = ./cloudflareCredentials.age;
  };
}
