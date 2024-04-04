disko.devices = {
  disk.main = {
    device = "CHANGEDISK";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          name = "boot";
          size = "1M";
          type = "EF02";
        };
        esp = {
          name = "ESP";
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "defaults" ];
          };
        };
        swap = {
          size = "32G";
          content = {
            type = "swap";
            resumeDevice = true;
          };
        };
        root = {
          name = "root";
          size = "100%";
          content = {
            type = "lvm_pv";
            vg = "root_vg";
          };
        };
      };
    };
  };
  lvm_vg = {
    root_vg = {
      type = "lvm_vg";
      lvs = {
        root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];

            subvolumes = {
              "/root" = {
                mountpoint = "/";
                mountOptions = ["subvol=root" "noatime" "compress=zstd"];
              };
              "/home" = {
                mountOptions = ["subvol=home" "noatime" "compress=zstd"];
                mountpoint = "/home";
              };
              "/persist" = {
                mountOptions = ["subvol=persist" "noatime" "compress=zstd"];
                mountpoint = "/persist";
              };
              "/nix" = {
                mountOptions = ["subvol=nix" "noatime" "compress=zstd"];
                mountpoint = "/nix";
              };
              "/var/log" = {
                mountOptions = ["subvol=log" "noatime" "compress=zstd"];
                mountpoint = "/var/log";
              };
            };
          };
        };
      };
    };
  };
};