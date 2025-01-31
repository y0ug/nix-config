{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vm";

  time.timeZone = "Europe/Paris";



 # services.displayManager.sddm = {
  #     enable = true;
  #     wayland.enable = true;
  # };

  # services.xserver.enable = true;

  # System-level GUI packages
  environment.systemPackages = with pkgs; [ 
  ];


  environment.localBinInPath = true;


  # SSH is enable
  services.openssh.enable = true;

  users.users.rick = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ tree neovim chezmoi kitty];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIILPlZ1DnETw4zdAVGB4uQL/MBj42qmPU3nzaR6g4SEe rick@mazenet.org"
    ];


    programs.hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # Xwayland can be disabled.
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
    };

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
