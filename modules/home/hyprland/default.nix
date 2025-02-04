{ inputs, ... }:
{
  imports = [
    ./hyprland.nix
    ./config.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./fuzzel.nix
  ];
}
