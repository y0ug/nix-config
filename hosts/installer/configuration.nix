{
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-base.nix")
  ];

  networking.hostName = "nixos-installer";
  # stateVersion set by installation-cd-base

  # --- Kernel / boot ---
  boot.supportedFilesystems.bcachefs = lib.mkDefault true;
  boot.zfs.package = pkgs.zfs_unstable;
  boot.initrd.systemd.emergencyAccess = true;
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.max_pool_percent=50"
    "zswap.compressor=zstd"
    "zswap.zpool=zsmalloc"
  ];

  # --- Networking (systemd-networkd + iwd for wifi) ---
  networking.useNetworkd = true;
  systemd.network.enable = true;
  networking.firewall.enable = false;
  networking.firewall.allowedUDPPorts = [ 5353 ];
  networking.tempAddresses = "disabled";

  # mDNS on all interfaces
  systemd.network.networks."99-ethernet-default-dhcp".networkConfig.MulticastDNS = "yes";
  systemd.network.networks."99-wireless-client-dhcp".networkConfig.MulticastDNS = "yes";

  # IWD instead of wpa_supplicant (use `iwctl` to connect)
  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = lib.mkForce false;
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
      };
      Settings.AutoConnect = true;
    };
  };

  # --- Pre-configure WiFi credentials ---
  # IWD reads network profiles from /var/lib/iwd/
  systemd.tmpfiles.rules = [
    "d /var/lib/iwd 0700 root root - -"
    "f /var/lib/iwd/mazenet.psk 0600 root root - [Security]\nPassphrase=the-ass-invokes-its-Landfill62"
  ];

  # --- SSH access ---
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIILPlZ1DnETw4zdAVGB4uQL/MBj42qmPU3nzaR6g4SEe rick@mazenet.org"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAygrx1Qt/Ev4q3lyMqPiRTAs8LGNuUJKidXCprQbBHvwGknVCreFvVz39+UHmPzFKYMI/Yelv0JCLY9Mc0jDtmOT3EKEN9dK+rcRhdNWDlwE/1cTCbWzIMd4qKYF8SrqrSdM2z97JOQbW3MLf6fv9r9BkPHKe2Eh/D4emlffgwlT4M/azjCNknluOMbSudTBFkcqfaBrtECj2pZ1kroFWkDohSoSndl8WDp2JZbFKYlrVl/g1ErrMG+A/M9ri6F5Abbnp9DOBhJmkpIo2jFSj2Mkl1Mr2z978735+IqDwu/5Z4WjcscTvwy7+oVCQHuqvcQ13dOGCU9e4ewE9aFE1 rick@levua"
  ];

  # Random root password displayed on console
  system.activationScripts.root-password = ''
    mkdir -p /var/shared
    ${pkgs.xkcdpass}/bin/xkcdpass --numwords 3 --delimiter - --count 1 > /var/shared/root-password
    echo "root:$(cat /var/shared/root-password)" | chpasswd
  '';

  # --- Console ---
  services.getty.autologinUser = lib.mkForce "root";
  console.earlySetup = true;
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u22n.psf.gz";

  # Tango colors
  console.colors = [
    "000000" "CC0000" "4E9A06" "C4A000"
    "3465A4" "75507B" "06989A" "D3D7CF"
    "555753" "EF2929" "8AE234" "FCE94F"
    "739FCF" "AD7FA8" "34E2E2" "EEEEEC"
  ];

  # --- Packages ---
  environment.systemPackages = with pkgs; [
    nixos-install-tools
    nixos-facter
    disko
    jq
    rsync
    git
    # networking tools
    networkmanager  # for nmtui/nmcli
    iw
    iwd
    wirelesstools   # iwconfig, iwlist
    wpa_supplicant  # wpa_cli as fallback
    iproute2
    iputils         # ping
    curl
    wget
    # disk tools
    parted
    gptfdisk
    dosfstools      # mkfs.vfat
    e2fsprogs       # mkfs.ext4
    btrfs-progs
    # general
    vim
    htop
    tmux
  ];

  # --- Misc ---
  documentation.enable = false;
  documentation.man.man-db.enable = false;
  system.installer.channel.enable = false;
  nix.settings = {
    connect-timeout = 5;
    extra-experimental-features = [ "nix-command" "flakes" ];
    log-lines = 25;
    max-free = 3000 * 1024 * 1024;
    min-free = 512 * 1024 * 1024;
    builders-use-substitutes = true;
  };
  nix.daemonCPUSchedPolicy = "batch";
  nix.daemonIOSchedClass = "idle";
  nix.daemonIOSchedPriority = 7;

  # Faster compression
  isoImage.squashfsCompression = "zstd";
  image.baseName = lib.mkForce "nixos-installer-${pkgs.stdenv.hostPlatform.system}";
}
