{ lib, inputs, pkgs, ... }:
{
  imports = [
    ./packages/common.nix
    ./packages/linux.nix
    ./packages/linux_gui.nix
    ./wezterm.nix # terminal
    ./kitty.nix # terminal
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./git.nix # version control

    ./hyprland.nix
    ./niri.nix
    ./sway.nix
    ./waybar
  ];
  #nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;


  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;

  # Make it non-blocking
  # systemd.services.home-manager-rick = {
  #   after = [ "graphical.target" ];
  #   wantedBy = lib.mkForce [ ];
  # };
}
