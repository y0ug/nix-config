{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/system.nix
    ../../modules/core/user.nix
    ../../modules/core/GUI
  ];
  boot.kernelModules = [ "hv_vmbus" "hv_storvsc" "hv_netvsc" "hyperv_fb" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vm";

  # System-level GUI packages
  environment.systemPackages = with pkgs; [ ];

  environment.localBinInPath = true;

  # SSH is enable
  services.openssh.enable = true;
}
