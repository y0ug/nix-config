{ ... }:
{
  imports = [
    ./config.nix
    ./packages.nix
    ../hyprland/fuzzel.nix
    ../hyprland/hypridle.nix
    ../swaync
  ];
}
