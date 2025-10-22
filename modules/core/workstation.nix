{ ... }:
{
  imports = [
    ./system.nix
    ./nvim.nix
    ./aider.nix
    ./python.nix
    ./flatpak.nix
    ./udev-rules.nix
  ];
}
