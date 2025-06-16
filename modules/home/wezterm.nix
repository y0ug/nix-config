{ config, pkgs, ... }:

{
  stylix.targets.wezterm.enable = false;

  home.packages = with pkgs; ([
    wezterm
    alacritty
    ghostty
  ]);
  # programs.wezterm = {
  #   enable = true;
  #   extraConfig = ''
  #     return {
  #       enable_scroll_bar = false,
  #       scrollback_lines = 10000,
  #
  #       use_fancy_tab_bar = false,
  #       enable_tab_bar = true,
  #       hide_tab_bar_if_only_one_tab = true,
  #       tab_bar_at_bottom=false,
  #
  #       front_end = "OpenGL",
  #       webgpu_power_preference = "HighPerformance",
  #       font = wezterm.font_with_fallback( { 'JetBrainsMono Nerd Font', {"weight" = "medium"}}),
  #     }
  #   '';
  #   #color_scheme = 'OneHalfDark',
  # };
  #
  # # apps.wezterm.colorscheme = lib.mkIf default "tokyonight_night";
  # # home.file.".config/wezterm/tokyonight_night.toml".source =
  # #   ../../themes/tokyonight/wezterm/tokyonight_night.toml;
  #
  # # "${pkgs.vimPlugins.tokyonight-nvim}/extras/wezterm/tokyonight_night.toml"
}
