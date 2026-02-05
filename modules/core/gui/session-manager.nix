{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Link wayland-sessions to system profile for tuigreet
  environment.pathsToLink = [ "/share/wayland-sessions" ];

  # Disable other display managers
  services.desktopManager.gnome.enable = lib.mkForce false;
  services.displayManager.ly.enable = lib.mkForce false;
  services.displayManager.sddm.enable = lib.mkForce false;

  # Ensure displayManager is enabled so sessionPackages from uwsm get linked
  services.displayManager.enable = true;

  # Add uwsm sessionPackages to systemPackages so they get linked via pathsToLink
  environment.systemPackages = [
    pkgs.tuigreet
  ] ++ config.services.displayManager.sessionPackages;

  # Greetd with tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # --sessions shows all available wayland sessions (Hyprland, Niri, Sway, etc.)
        command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions /run/current-system/sw/share/wayland-sessions";
      };
      terminal = {
        vt = lib.mkForce 4;
      };
    };
  };

  # PAM services for session management
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    tuigreet.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
}
