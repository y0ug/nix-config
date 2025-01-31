{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vm";

  time.timeZone = "Europe/Paris";

  # System-level GUI packages
  environment.systemPackages = with pkgs; [ xorg.xkill xorg.xrandr i3 lightdm ];

  # X11 configuration
  services.xserver = {
    enable = true;
    # displayManager.lightdm.enable = true;
    displayManager = { defaultSession = "none+i3"; };
    windowManager.i3.enable = true;
  };

  # SSH is enable
  services.openssh.enable = true;

  users.users.rick = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ tree neovim chezmoi ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIILPlZ1DnETw4zdAVGB4uQL/MBj42qmPU3nzaR6g4SEe rick@mazenet.org"
    ];
  };

  home-manager.backupFileExtension = "backup-" + pkgs.lib.readFile
    "${pkgs.runCommand "timestamp" { }
    "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters =
        [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [ "root" "wheel" ];
    };
  };
}
