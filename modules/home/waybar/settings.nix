{ lib, ... }:
{
  programs.waybar.settings.mainBar = {
    # "layer" = "top" # Waybar at top layer
    # "position" = "bottom" # Waybar position (top|bottom|left|right)
    "height" = 30; # Waybar height (to be removed for auto height)
    # "width" = 1280; # Waybar width
    "spacing" = 4; # Gaps between modules (4px)

    "modules-left" = [
      "hyprland/workspaces"
      "hyprland/submap"
      "hyprland/window"
    ];
    "modules-center" = [
    ];
    "modules-right" = [
      "idle_inhibitor"
      "custom/notification"
      "privacy"
      "pulseaudio"
      "network"
      # "power-profiles-daemon"
      # "cpu"
      # "memory"
      # "temperature"
      # "backlight"
      # "hyprland/language"
      "battery"
      "clock"
      "tray"
    ];

    "hyprland/workspaces" = {
      # all-outputs = true;
      on-scroll-up = "hyprctl dispatch workspace r-1";
      on-scroll-down = "hyprctl dispatch workspace r+1";
      # "format" = "{name}: {icon}";
      # "format-icons" = {
      #   "1" = "";
      #   "2" = "";
      #   "3" = "";
      #   "4" = "";
      #   "5" = "";
      #   "active" = "";
      #   "default" = "";
      # };
      "persistent-workspaces" = {
        # "DP-1" = 6; # 5 workspaces by default on every monitor
        # "HDMI-A-2" = 1; # but only three on HDMI-A-1
      };
    };

    "hyprland/window" = {
      "format" = "❯ {}";

      "rewrite" = {
        "(.*) — Mozilla Firefox" = "🌎 $1";
      };
      "separate-outputs" = true;
    };

    "hyprland/submap" = {
      "format" = "✌️ {}";
      "max-length" = 8;
      "tooltip" = false;
    };

    "privacy" = {
      "icon-spacing" = 4;
      "icon-size" = 18;
      "transition-duration" = 250;
      "modules" = [
        {
          "type" = "screenshare";
          "tooltip" = true;
          "tooltip-icon-size" = 24;
        }
        # {
        #   "type" = "audio-out";
        #   "tooltip" = true;
        #   "tooltip-icon-size" = 24;
        # }
        {
          "type" = "audio-in";
          "tooltip" = true;
          "tooltip-icon-size" = 24;
        }
      ];
    };

    "keyboard-state" = {
      "numlock" = true;
      "capslock" = true;
      "format" = "{name} {icon}";
      "format-icons" = {
        "locked" = "";
        "unlocked" = "";
      };
    };

    "idle_inhibitor" = {
      "format" = "{icon}";
      "format-icons" = {
        "activated" = "";
        "deactivated" = "";
      };
    };
    "tray" = {
      # "icon-size" = 21;
      "spacing" = 10;
    };

    "clock" = {
      # "timezone" = "America/New_York"
      "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      "format-alt" = "{:%Y-%m-%d}";
    };

    "cpu" = {
      "format" = "{usage}% ";
      "tooltip" = false;
    };

    "memory" = {
      "format" = "{}% ";
    };

    "temperature" = {
      # "thermal-zone" = 2;
      # "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input"
      "critical-threshold" = 80;
      # "format-critical" = "{temperatureC}°C {icon}"
      "format" = "{temperatureC}°C {icon}";
      "format-icons" = [
        ""
        ""
        ""
      ];
    };

    "backlight" = {
      # "device" = "acpi_video1"
      "format" = "{percent}% {icon}";
      "format-icons" = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
    };

    "battery" = {
      "states" = {
        # "good" = 95;
        "warning" = 30;
        "critical" = 15;
      };
      "format" = "{capacity}% {icon}";
      "format-full" = "{capacity}% {icon}";
      "format-charging" = "{capacity}% ";
      "format-plugged" = "{capacity}% ";
      "format-alt" = "{time} {icon}";
      # "format-good" = "" # An empty format will hide the module
      # "format-full" = ""
      "format-icons" = [
        ""
        ""
        ""
        ""
        ""
      ];
    };

    "battery#bat2" = {
      "bat" = "BAT2";
    };

    "power-profiles-daemon" = {
      "format" = "{icon}";
      "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
      "tooltip" = true;
      "format-icons" = {
        "default" = "";
        "performance" = "";
        "balanced" = "";
        "power-saver" = "";
      };
    };

    "network" = {
      # "interface" = "wlp2*" # (Optional) To force the use of this interface
      "format-wifi" = "{essid} ({signalStrength}%) ";
      "format" = "";
      "format-ethernet" = " ";
      "tooltip-format" = "{ifname} via {gwaddr} ";
      "format-linked" = "(No IP) ";
      "format-disconnected" = "⚠";
      "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    };

    "pulseaudio" = {
      "scroll-step" = 5; # %, can be a float
      "format" = "{volume}% {icon} {format_source}";
      "format-muted" = "󰝟 {format_source}";
      # "format-muted" = " {format_source}";
      # "format-bluetooth" = "{volume}% {icon} {format_source}";
      # "format-bluetooth-muted" = " {icon} {format_source}";
      # "format-muted" = " {format_source}";
      # "format-source" = "{volume}% ";
      "format-source" = "";
      "format-source-muted" = "";
      "format-icons" = {
        "headphone" = "";
        "hands-free" = "";
        "headset" = "";
        "phone" = "";
        "portable" = "";
        "car" = "";
        "default" = [
          ""
          ""
          ""
        ];
      };
      "on-click" = "pavucontrol";
      "on-click-right" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "on-click-middle" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
    };

    "custom/notification" = {
      "tooltip" = false;
      "format" = "{icon}";
      "format-icons" = {
        "notification" = "<span foreground='red'><sup></sup></span>";
        "none" = "";
        "dnd-notification" = "<span foreground='red'><sup></sup></span>";
        "dnd-none" = "";
        "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
        "inhibited-none" = "";
        "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
        "dnd-inhibited-none" = "";
      };

      "return-type" = "json";
      "exec-if" = "which swaync-client";
      "exec" = "swaync-client -swb";
      "on-click" = "swaync-client -t -sw";
      "on-click-right" = "swaync-client -d -sw";
      "escape" = true;
    };
  };
}
