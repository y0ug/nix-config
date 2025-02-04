{ config, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        enable_scroll_bar = false,
        use_fancy_tab_bar = false,
        enable_tab_bar = true,
        scrollback_lines = 10000,
        front_end = "OpenGL",
        webgpu_power_preference = "HighPerformance",
        font = wezterm.font_with_fallback( { 'JetBrainsMono Nerd Font Mono', }),
        color_scheme = 'tokyonight_night',
      }
    '';
    #color_scheme = 'OneHalfDark',
  };

  # apps.wezterm.colorscheme = lib.mkIf default "tokyonight_night";
  home.file.".config/wezterm/tokyonight_night.toml".source =
    ../../themes/tokyonight/wezterm/tokyonight_night.toml;

  # "${pkgs.vimPlugins.tokyonight-nvim}/extras/wezterm/tokyonight_night.toml"
}
