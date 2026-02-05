{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  services.input-remapper.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    # set the flake package
    # package = pkgs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    # inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = false;
    extraPortals = [
      # inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-termfilechooser
    ];
    config = {
      common = {
        default = [
          "gtk"
        ];
        # "org.freedesktop.impl.portal.FileChooser" = [ "xdg-desktop-portal-termfilechooser" ];
      };
      hyprland = {
        default = [
          "gtk"
          "hyprland"
        ];
        # "org.freedesktop.impl.portal.FileChooser" = [ "xdg-desktop-portal-termfilechooser" ];
      };
    };
  };

  security.pam.services = {
    hyprlock.enableGnomeKeyring = true;
    hyprland.enableGnomeKeyring = true;
  };

  security.polkit.enable = true;

  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    # passSecretService.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
