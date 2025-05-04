{ pkgs, ... }:

{
  imports = [
    ../packages/hyprland.nix
  ];
  
  # Disable other display managers
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.displayManager.lightdm.enable = false;
  services.displayManager.ly.enable = false;
  services.displayManager.sddm.enable = false;
  
  # Enable greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland-uwsm.desktop'";
      };
      terminal = {
        vt = "4";
      };
    };
  };
  
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  
  # Integrate with system components
  programs.dconf.enable = true;
  security.pam.services = {
    hyprlock.enableGnomeKeyring = true;
    sddm.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
    ly.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
    hyprland.enableGnomeKeyring = true;
  };
}