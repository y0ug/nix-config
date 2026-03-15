{ config, pkgs, ... }:
{
  imports = [
    ../modules/home/desktop.nix
    ../modules/home/packages/work.nix
    ../modules/home/xdg/default-apps.nix
  ];

  home.username = "rick";
  home.homeDirectory = "/home/rick";
  home.stateVersion = "25.11";
}
