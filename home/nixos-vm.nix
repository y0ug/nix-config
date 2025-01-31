{ config, pkgs, ... }: {
  imports = [ ./linux.nix ../programs/hyprland.nix ../programs/wezterm.nix ];

  home.username = "rick";
  home.homeDirectory = "/home/rick";

  home.packages = with pkgs; [ firefox ];


}
