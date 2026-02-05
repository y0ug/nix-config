{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  toggle = app: "pkill ${app} || uwsm app -u ${app}.scope -- ${app}";
  run = "uwsm app --";
  terminal = "${run} $TERMINAL";
  fileManager = "${run} $TERMINAL yazi";
  menu = "${toggle "fuzzel"} --launch-prefix='${run}'";
  browser = "${run} ${lib.getExe pkgs.ungoogled-chromium}";
  mod = "Mod4"; # Super key
in
{
  # UWSM environment variables for Sway
  xdg.configFile."uwsm/env-sway".text = builtins.concatStringsSep "\nexport " [
    ""
    "QT_WAYLAND_DISABLE_WINDOWDECORATION=1"
    "ELECTRON_OZONE_PLATFORM_HINT=wayland"
    "TERMINAL=${pkgs.foot}/bin/foot"
    "XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
    "ZK_NOTEBOOK_DIR=$HOME/Notebook"
    # Accessibility
    "ACCESSIBILITY_ENABLED=1"
    "GTK_MODULES=gail:atk-bridge"
    "OOO_FORCE_DESKTOP=gnome"
    "GNOME_ACCESSIBILITY=1"
    "QT_ACCESSIBILITY=1"
    "QT_LINUX_ACCESSIBILITY_ALWAYS_ON=1"
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = mod;
      terminal = "sh -c '${terminal}'";
      menu = "sh -c '${menu}'";

      input = {
        "*" = {
          xkb_layout = "us";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "disabled";
        };
      };

      gaps = {
        inner = 0;
        outer = 0;
      };

      window = {
        border = 3;
        titlebar = false;
      };

      floating = {
        border = 3;
        titlebar = false;
      };

      focus = {
        followMouse = true;
      };

      output = {
        "HDMI-A-2" = {
          position = "0 0";
        };
        "DP-1" = {
          position = "2560 0";
        };
      };

      bars = [ ]; # We use waybar (started via systemd/UWSM)

      startup = [
        { command = "wl-paste --type text --watch cliphist store"; }
        { command = "wl-paste --type image --watch cliphist store"; }
        { command = "swaync"; }
      ];

      keybindings = lib.mkOptionDefault {
        # Session
        "${mod}+Ctrl+Escape" = "exec swaylock";
        "${mod}+Ctrl+Shift+Escape" = "exec wlogout";
        "${mod}+Shift+e" = "exec swaynag -t warning -m 'Exit sway?' -B 'Yes' 'swaymsg exit'";

        # Applications
        "${mod}+Return" = "exec sh -c '${terminal}'";
        "${mod}+t" = "exec sh -c '${terminal}'";
        "${mod}+e" = "exec sh -c '${fileManager}'";
        "${mod}+space" = "exec sh -c '${menu}'";
        "${mod}+b" = "exec sh -c '${browser}'";
        "${mod}+Shift+n" = "exec swaync-client -t -sw";
        "${mod}+Shift+v" = "exec sh -c 'cliphist list | fuzzel --dmenu | cliphist decode | wl-copy'";

        # Screenshots
        "${mod}+s" = "exec grim -g \"$(slurp)\" - | satty -f -";
        "${mod}+Ctrl+s" = "exec grim - | satty -f -";
        "${mod}+Shift+s" = "exec grim -g \"$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | \"\\(.x),\\(.y) \\(.width)x\\(.height)\"')\" - | satty -f -";

        # Window management
        "${mod}+Shift+q" = "kill";
        "${mod}+f" = "floating toggle";
        "${mod}+Shift+Return" = "fullscreen toggle";

        # Focus movement
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # Move windows
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Resize
        "${mod}+Alt+h" = "resize shrink width 20px";
        "${mod}+Alt+j" = "resize grow height 20px";
        "${mod}+Alt+k" = "resize shrink height 20px";
        "${mod}+Alt+l" = "resize grow width 20px";

        # Layout
        "${mod}+minus" = "splitv";
        "${mod}+backslash" = "splith";
        "${mod}+w" = "layout tabbed";
        "${mod}+Shift+w" = "layout toggle split";

        # Workspaces
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        # Workspace navigation
        "${mod}+bracketleft" = "workspace prev";
        "${mod}+bracketright" = "workspace next";
        "${mod}+grave" = "workspace back_and_forth";

        # Monitor movement
        "${mod}+o" = "focus output right";
        "${mod}+Shift+o" = "move container to output right";

        # Scratchpad
        "${mod}+z" = "scratchpad show";
        "${mod}+Shift+z" = "move scratchpad";

        # Media keys
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl s 10%+";
        "XF86MonBrightnessDown" = "exec brightnessctl s 10%-";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
      };

      window.commands = [
        # Floating rules
        { criteria = { title = "^Picture-in-Picture$"; }; command = "floating enable"; }
        { criteria = { app_id = "^pavucontrol$"; }; command = "floating enable"; }
        { criteria = { app_id = "^blueman-manager$"; }; command = "floating enable"; }
        { criteria = { app_id = "^nm-connection-editor$"; }; command = "floating enable"; }
        { criteria = { app_id = "^qalculate-gtk$"; }; command = "floating enable"; }
        { criteria = { app_id = "^xdg-desktop-portal-gtk$"; }; command = "floating enable"; }
        { criteria = { title = "^(Open|Save|Choose)"; }; command = "floating enable"; }
      ];
    };
  };
}
