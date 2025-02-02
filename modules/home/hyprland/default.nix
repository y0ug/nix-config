{ inputs, ... }:
{
  imports = [
    ./hyprland.nix
    ./config.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./variables.nix
    # inputs.hyprland.homeManagerModules.default
  ];
}
