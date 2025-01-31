{ config, pkgs, ... }:
{
  networking.hostName = "nixos-vm";

  # System-level GUI packages
  environment.systemPackages = with pkgs; [
    xorg.xkill
    xorg.xrandr
    i3
    lightdm
  ];

  # X11 configuration
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };

  # ... rest of your NixOS VM configuration
}
