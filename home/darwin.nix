{ config, pkgs, ... }:
{
  imports = [
    ../modules/home/packages/common.nix
    ../modules/home/wezterm.nix
  ];

  home.username = "rick";
  home.homeDirectory = "/Users/rick";

  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    vscodium
    glances
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];
  # macOS-specific overrides
  # programs.wezterm.extraConfig = config.programs.wezterm.extraConfig + ''
  #   -- macOS-specific tweaks
  #   config.enable_tab_bar = false
  # '';
}
