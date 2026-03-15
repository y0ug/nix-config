{ config, pkgs, ... }:
{
  imports = [
    ../modules/home/desktop.nix
    ../modules/home/packages/work.nix
    ../modules/home/packages/commercial.nix
    ../modules/home/xdg/default-apps.nix
  ];

  home.username = "rick";
  home.homeDirectory = "/home/rick";
  home.stateVersion = "24.05";

  # Potentially host-specific overrides can live here.
}
