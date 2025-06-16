{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.stylix) fonts;
  inherit (config.lib.stylix) colors;
in
{
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = false;
      };

      # Uncomment to enable fingerprint authentication
      # auth = {
      #   fingerprint = {
      #     enabled = true;
      #     ready_message = "Scan fingerprint to unlock";
      #     present_message = "Scanning...";
      #     retry_delay = 250; # in milliseconds
      #   };
      # };

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = {
        monitor = "";
        path = "screenshot";
        color = "rgb(${colors.base00})";
        blur_size = 4;
        blur_passes = 6;
      };

      input-field = [
        {
          monitor = "";
          size = "20%, 5%";
          outline_thickness = 3;

          # Using Stylix colors
          # outer_color = "rgba(${colors.base0A}ee)";
          # inner_color = "rgba(${colors.base07}00)";
          # check_color = "rgba(${colors.base0B}ee)";
          # fail_color = "rgba(${colors.base08}ee)";
          outer_color = "rgb(${colors.base0A})";
          inner_color = "rgb(${colors.base07})";
          check_color = "rgb(${colors.base0B})";
          fail_color = "rgb(${colors.base08})";

          font_color = "rgb(${colors.base06})";
          fade_on_empty = true;
          rounding = 15;

          # Using Stylix monospace font
          font_family = "${fonts.monospace.name}";
          placeholder_text = "Input password...";
          fail_text = "$PAMFAIL";

          dots_spacing = 0.3;

          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      # Time label
      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 90;
          # Using Stylix monospace font
          font_family = "${fonts.monospace.name}";

          position = "-30, 0";
          halign = "right";
          valign = "top";
          color = "rgb(${colors.base04})";
        }

        # Date label
        {
          monitor = "";
          text = "cmd[update:60000] date +\"%A, %d %B %Y\""; # update every 60 seconds
          font_size = 25;
          # Using Stylix monospace font
          font_family = "${fonts.monospace.name}";

          position = "-30, -150";
          halign = "right";
          valign = "top";
          color = "rgb(${colors.base04})";
        }

        # Layout label
        #   monitor = "";
        #   text = "$LAYOUT[en,ru]";
        #   font_size = 24;
        #   onclick = "hyprctl switchxkblayout all next";
        #   # Using Stylix monospace font
        #   font_family = "${fonts.monospace.name}";
        #
        #   position = "250, -20";
        #   halign = "center";
        #   valign = "center";
        #   color = "rgb(${colors.base0D})";
        # }
      ];
    };
  };
}
