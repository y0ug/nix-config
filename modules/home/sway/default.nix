{ ... }:
{
  imports = [
    ./config.nix
    ./packages.nix
    ./swayidle.nix
    ../hyprland/fuzzel.nix
    ../swaync
  ];
}
