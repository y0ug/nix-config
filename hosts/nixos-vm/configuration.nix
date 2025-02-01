{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/system.nix
    ../../modules/core/user.nix
    ../../modules/core/GUI
    ../../modules/core/GUI/hyprland.nix
  ];
  boot.kernelModules = [ "hv_vmbus" "hv_storvsc" "hv_netvsc" "hyperv_fb" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "24.11";

  networking.hostName = "nixos-vm";

  environment.systemPackages = with pkgs; [ ];

  environment.localBinInPath = true;

  services.xserver.displayManager.gdm.autoSuspend = false;

  # SSH is enable
  services.openssh.enable = true;
}
