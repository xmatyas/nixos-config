{ inputs, config, pkgs, lib, ... }: 
{

  system.stateVersion = "23.05";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  networking.useDHCP = true;

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
    ports = [ 69 ];
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
  
  networking.firewall.allowedTCPPorts = [
   5201 # iperf3 
  ];

  networking.firewall.allowPing = true;

  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    pciutils
    cpufrequtils
    iperf3
    exa
    neofetch
    tmux
    rsync
    iotop
    hdparm
    hd-idle
    hddtemp
    smartmontools
    ncdu
    nmap
    btop
    tree
    inputs.agenix.packages."${system}".default
  ];
}
