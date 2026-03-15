{ config, pkgs, ... }:
{
  imports = [
    ../modules/home/desktop.nix
    # TODO: re-enable after copying commercial installers (binaryninja, ida-pro)
    # ../modules/home/packages/work.nix
    ../modules/home/xdg/default-apps.nix
  ];

  home.username = "rick";
  home.homeDirectory = "/home/rick";
  home.stateVersion = "25.11";
}
