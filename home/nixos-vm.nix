{ config, pkgs, ... }:
{
  imports = [
    ./linux.nix
    ../programs/i3.nix
    ../programs/wezterm.nix
  ];

  home.username = "rick";
  home.homeDirectory = "/home/rick";

  home.packages = with pkgs; [
    # firefox
  ];

  programs.i3.enable = true
  programs.wezterm.enable = true

  programs.i3.config.startup = [
    { command = "exec ${pkgs.nitrogen}/bin/nitrogen --restore"; }
  ];
}
