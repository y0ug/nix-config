{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  services.xserver.desktopManager.gnome.enable = lib.mkForce false;
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
  # services.displayManager.ly.enable = lib.mkForce true;
  services.displayManager.sddm.enable = lib.mkForce true;

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
    ];
  };

  security.pam.services = {
    hyprlock.enableGnomeKeyring = true;
    sddm.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
    ly.enableGnomeKeyring = true;
  };
  security.polkit.enable = true;

  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    # passSecretService.enable = true;
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
