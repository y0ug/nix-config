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
in
{
  # UWSM environment variables for Niri
  xdg.configFile."uwsm/env-niri".text = builtins.concatStringsSep "\nexport " [
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

  # Niri config in KDL format
  xdg.configFile."niri/config.kdl".text = ''
    // Input configuration
    input {
        keyboard {
            xkb {
                layout "us"
            }
        }
        mouse {
            accel-profile "adaptive"
        }
        touchpad {
            tap
            // natural-scroll
            accel-profile "adaptive"
        }
        warp-mouse-to-focus
        focus-follows-mouse max-scroll-amount="0%"
    }

    // Output configuration - adjust to your monitors
    output "DP-1" {
        mode "2560x1440@144"
        position x=0 y=0
        variable-refresh-rate
    }

    // Layout
    layout {
        gaps 0
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 1
        }

        border {
            off
        }
    }

    // Startup applications
    spawn-at-startup "sh" "-c" "wl-paste --type text --watch cliphist store"
    spawn-at-startup "sh" "-c" "wl-paste --type image --watch cliphist store"
    spawn-at-startup "waybar"
    spawn-at-startup "swaync"
    spawn-at-startup "xwayland-satellite"

    // Prefer no client-side decorations
    prefer-no-csd

    // Screenshot path
    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    // Window rules
    window-rule {
        match title=r#"^Picture-in-Picture$"#
        open-floating true
    }

    window-rule {
        match app-id=r#"^(pavucontrol|blueman-manager|nm-connection-editor|qalculate-gtk)$"#
        open-floating true
    }

    window-rule {
        match app-id=r#"^xdg-desktop-portal-gtk$"#
        open-floating true
    }

    // Keybindings
    binds {
        // Session
        Mod+Ctrl+Escape { spawn "swaylock"; }
        Mod+Ctrl+Shift+Escape { spawn "wlogout"; }
        Mod+Shift+E { quit skip-confirmation=true; }

        // Applications
        Mod+Return { spawn "sh" "-c" "${terminal}"; }
        Mod+T { spawn "sh" "-c" "${terminal}"; }
        Mod+E { spawn "sh" "-c" "${fileManager}"; }
        Mod+Space { spawn "sh" "-c" "${menu}"; }
        Mod+B { spawn "sh" "-c" "${browser}"; }
        Mod+Shift+N { spawn "swaync-client" "-t" "-sw"; }
        Mod+Shift+V { spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }

        // Screenshots
        Mod+S { screenshot; }
        Mod+Ctrl+S { screenshot-screen; }
        Mod+Shift+S { screenshot-window; }

        // Window management
        Mod+Shift+Q { close-window; }

        // Focus movement
        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+J { focus-window-down; }
        Mod+K { focus-window-up; }
        Mod+Left { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Down { focus-window-down; }
        Mod+Up { focus-window-up; }

        // Move windows
        Mod+Shift+H { move-column-left; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+J { move-window-down; }
        Mod+Shift+K { move-window-up; }
        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Down { move-window-down; }
        Mod+Shift+Up { move-window-up; }

        // Resize
        Mod+Alt+H { set-column-width "-10%"; }
        Mod+Alt+L { set-column-width "+10%"; }
        Mod+Alt+J { set-window-height "+10%"; }
        Mod+Alt+K { set-window-height "-10%"; }

        // Column width presets
        Mod+R { switch-preset-column-width; }
        Mod+F { maximize-column; }
        Mod+Shift+Return { fullscreen-window; }

        // Floating
        Mod+V { toggle-window-floating; }
        Mod+Shift+C { center-column; }

        // Consume/expel windows between columns
        Mod+Comma { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        // Workspaces
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+0 { focus-workspace 10; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }
        Mod+Shift+0 { move-column-to-workspace 10; }

        // Workspace navigation
        Mod+BracketLeft { focus-workspace-down; }
        Mod+BracketRight { focus-workspace-up; }
        Mod+Shift+BracketLeft { move-column-to-workspace-down; }
        Mod+Shift+BracketRight { move-column-to-workspace-up; }
        Mod+Grave { focus-workspace-previous; }

        // Monitor movement
        Mod+O { focus-monitor-next; }
        Mod+Shift+O { move-column-to-monitor-next; }

        // Tab cycling
        Alt+Tab { focus-window-down-or-column-right; }
        Alt+Shift+Tab { focus-window-up-or-column-left; }

        // Media keys
        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "s" "10%+"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "s" "10%-"; }
        XF86AudioPlay allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioPause allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioNext allow-when-locked=true { spawn "playerctl" "next"; }
        XF86AudioPrev allow-when-locked=true { spawn "playerctl" "previous"; }
    }
  '';
}
