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
      front_end = "WebGpu",
      webgpu_power_preference = "HighPerformance",
      font = wezterm.font_with_fallback( { 'JetBrainsMono Nerd Font Mono', }),
      color_scheme = 'OneHalfDark',
    }
    '';
  };
}
