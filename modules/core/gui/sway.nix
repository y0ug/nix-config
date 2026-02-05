{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  # Sway compositor
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Add Sway portal config (override nixpkgs default)
  xdg.portal.config.sway = {
    default = lib.mkForce [
      "wlr"
      "gtk"
    ];
  };
  programs.uwsm = {
    enable = true;
    # You must configure the waylandCompositors suboptions so that UWSM knows which compositors to manage.
    waylandCompositors = {
      sway = {
        prettyName = "Sway";
        comment = "Sway compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/sway";
      };
    };
  };
  # PAM for swaylock
  security.pam.services.swaylock.enableGnomeKeyring = true;
}
