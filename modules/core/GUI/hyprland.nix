{ pkgs, lib, ... }:
{
  services.xserver.desktopManager.gnome.enable = lib.mkForce false;
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
  services.displayManager.ly.enable = lib.mkForce false;
  services.xserver.displayManager.sddm.enable = lib.mkForce true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  security.pam.services = {
    hyprlock.enableGnomeKeyring = true;
  };
  security.polkit.enable = true;

  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
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
