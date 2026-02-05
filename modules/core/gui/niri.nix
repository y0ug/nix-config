{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  # Niri compositor
  programs.niri = {
    enable = true;
  };

  # UWSM session management for Niri
  programs.uwsm = {
    enable = true;
    waylandCompositors.niri = {
      binPath = "/run/current-system/sw/bin/niri";
      prettyName = "Niri";
      comment = "Niri scrolling window manager";
    };
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite # XWayland support for Niri
  ];

  # Add Niri portal config
  xdg.portal.config.niri = {
    default = [
      "gnome"
      "gtk"
    ];
  };

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gnome
  ];

  # PAM for swaylock
  security.pam.services.swaylock.enableGnomeKeyring = true;
}
