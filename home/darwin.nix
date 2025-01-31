{ config, pkgs, ...}:
{
  imports = [ ./common.nix 
    ./programs/wezterm.nix
  ];

  home.packages = with pkgs; [
    vscode
    glances
  ]

  # macOS-specific overrides
  # programs.wezterm.extraConfig = config.programs.wezterm.extraConfig + ''
  #   -- macOS-specific tweaks
  #   config.enable_tab_bar = false
  # '';
}
