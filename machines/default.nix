{ inputs, config, pkgs, lib, ... }: 
{

  system.stateVersion = "23.11";

  networking.useDHCP = true;
  # This is needed for containers to reach the internet. NetworkManager tries to manage the containers if enabled.
  networking.networkmanager.enable = false;

  time = {
   timeZone = "Europe/Bratislava";
   hardwareClockInLocalTime = true;
  };

   #users.users = {
   # root = {
   #   initialHashedPassword = config.age.secrets.hashedUserPassword.path;
   #   openssh.authorizedKeys.keys = [ "sshKey_placeholder" ];
   # };
  # };
  services.openssh = {
    enable = lib.mkDefault true;
    settings = {
    PasswordAuthentication = lib.mkDefault true; 
    PermitRootLogin = "no";
    };
    ports = [ 61 ];
    hostKeys = [
      {
        path = "/persist/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/persist/ssh/ssh_host_rsa_key";
        type = "rsa";
        bits = 4096;
      }
    ];
  };

  nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];

  programs.git.enable = true;
  programs.mosh.enable = true;
  programs.htop.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  security = {
    doas.enable = lib.mkDefault false;
    sudo = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault false;
    };
  };
  
  networking.firewall.allowPing = true;

  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    pciutils
    usbutils
    cpufrequtils
    eza
    neofetch
    tmux
    rsync
    nmap
    btop
    tree
    powertop
    inputs.agenix.packages."${system}".default
  ];
}
