{ config, pkgs, ... }:
{
  imports = [
    ../modules/home/desktop.nix
    ../modules/home/packages/work.nix
  ];

  home.username = "rick";
  home.homeDirectory = "/home/rick";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [ firefox ];

}
