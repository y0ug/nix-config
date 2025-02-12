# { pkgs, ... }:
# {
#   programs.hyprlock = {
#     enable = true;
#
#     # need to be at the end
#     extraConfig = ''
#       source = ~/.config/hypr/hyprlock-background.conf
#     '';
#
#     settings = {
#       general = {
#         # disable_loading_bar = true;
#         # immediate_render = true;
#         # hide_cursor = false;
#         # no_fade_in = true;
#       };
#
#       # background = [
#       #   {
#       #     monitor = "";
#       #     color = "rgba(25, 20, 20, 1.0)";
#       #     # path = config.theme.wallpaper;
#       #     path = "screenshot";
#       #     blur_passes = 4;
#       #     blur_size = 6;
#       #   }
#       # ];
#       #
#       input-field = [
#         {
#           monitor = "";
#
#           size = "300, 50";
#           valign = "bottom";
#           position = "0%, 10%";
#
#           outline_thickness = 1;
#
#           font_color = "rgb(b6c4ff)";
#           outer_color = "rgba(180, 180, 180, 0.5)";
#           inner_color = "rgba(200, 200, 200, 0.1)";
#           # check_color = "rgba(247, 193, 19, 0.5)";
#           fail_color = "rgba(255, 106, 134, 0.5)";
#
#           fade_on_empty = false;
#           placeholder_text = "Enter Password";
#
#           dots_spacing = 0.2;
#           dots_center = true;
#           dots_fade_time = 100;
#
#           shadow_color = "rgba(0, 0, 0, 0.1)";
#           shadow_size = 7;
#           shadow_passes = 2;
#         }
#       ];
#
#       label = [
#         {
#           monitor = "";
#           text = "$TIME";
#           font_size = 150;
#           color = "rgb(b6c4ff)";
#
#           position = "0%, 30%";
#
#           valign = "center";
#           halign = "center";
#
#           shadow_color = "rgba(0, 0, 0, 0.1)";
#           shadow_size = 20;
#           shadow_passes = 2;
#           shadow_boost = 0.3;
#         }
#         {
#           monitor = "";
#           text = "cmd[update:3600000] date +'%a %b %d'";
#           font_size = 20;
#           color = "rgb(b6c4ff)";
#
#           position = "0%, 40%";
#
#           valign = "center";
#           halign = "center";
#
#           shadow_color = "rgba(0, 0, 0, 0.1)";
#           shadow_size = 20;
#           shadow_passes = 2;
#           shadow_boost = 0.3;
#         }
#       ];
#     };
#
#   };
#
{
  inputs,
  config,
  pkgs,
  ...
}:
let
  inherit (config.lib.stylix) colors;
in
{
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    # settings = {
    #   general = {
    #     disable_loading_bar = false;
    #   };
    #
    #   background = [
    #     {
    #       path = "screenshot";
    #       blur_passes = 4;
    #       blur_size = 6;
    #     }
    #   ];

    settings = {
      general = {
        disable_loading_bar = false;
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
        no_fade_out = false;
        ignore_empty_input = false;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          color = "rgba(25, 20, 20, 1.0)";
          blur_size = 4;
          blur_passes = 6;
          noise = 0.011700;
          contrast = 0.891700;
          brightness = 0.500000;
          vibrancy = 0.168600;
          vibrancy_darkness = 0.050000;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.200000;
          dots_spacing = 0.200000;
          dots_center = true;
          dots_rounding = -1;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          fade_timeout = 1000;
          placeholder_text = ''<b><span foreground="##cdd6f4">Input Password...</span></b>'';
          hide_input = false;
          rounding = -1;
          shadow_passes = 0;
          shadow_size = 3;
          shadow_color = "rgba(0, 0, 0, 1.0)";
          shadow_boost = 1.200000;
          check_color = "rgb(204, 136, 34)";
          fail_color = "rgb(204, 34, 34)";
          fail_text = "<i>$FAIL</i>";
          fail_transition = 300;
          capslock_color = -1;
          numlock_color = -1;
          bothlock_color = -1;
          invert_numlock = false;
          swap_font_color = false;
          position = "0, -150";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 120;
          font_famyly = config.stylix.fonts.serif.name;
          rotate = 0.000000;
          shadow_passes = 0;
          shadow_size = 3;
          shadow_color = "rgba(0, 0, 0, 1.0)";
          shadow_boost = 1.200000;

          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "$LAYOUT";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 20;
          font_famyly = config.stylix.fonts.serif.name;
          rotate = 0.000000;
          shadow_passes = 0;
          shadow_size = 3;
          shadow_color = "rgba(0, 0, 0, 1.0)";
          shadow_boost = 1.200000;

          position = "0, -80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
