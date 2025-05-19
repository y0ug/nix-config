{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  # toggle = app: "pkill ${app} || uwsm app -u ${app}.scope -- ${app}";
  # runOnce = app: "pgrep ${app} || uwsm app -- ${app}";
  # toggle = app: "systemctl --user stop ${app}.scope || uwsm app -u ${app}.scope -- ${app}";
  toggle = app: "pkill ${app} || uwsm app -u ${app}.scope -- ${app}";
  runOnce = app: "uwsm app -u ${app}.scope -- ${app}";
  run = "uwsm app --";
in
# cursorName = "Bibata-Modern-Classic";
# pointerSize = 16;
{
  xdg.configFile."uwsm/env-hyprland".text = builtins.concatStringsSep "\nexport " [
    "QT_WAYLAND_DISABLE_WINDOWDECORATION=1"
    "ELECTRON_OZONE_PLATFORM_HINT=wayland"
    "TERMINAL=kitty"
    "HYPRSHOT_DIR=$HOME/Pictures"
    "XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
    "ZK_NOTEBOOK_DIR=$HOME/Notebook"
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hy3
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
      # inputs.hy3.packages.${pkgs.stdenv.hostPlatform.system}.hy3
    ];
    settings = {
      # we used UWSM so no env here
      env = [
      ];

      "$mainMod" = "SUPER";

      "$mainMonitor" = "DP-1";

      device = [
        {
          name = "kensington-slimblade-pro(2.4ghz-receiver)-kensington-slimblade-pro-trackball(2.4ghz-receiver)";
          natural_scroll = false;
          sensitivity = 0.5;
          accel_profile = "adaptive";
        }
        {
          name = "ploopy-corporation-ploopy-adept-trackball-mouse";
          natural_scroll = false;
          sensitivity = -0.8;
          accel_profile = "adaptive";
        }
      ];
      plugin = {
        # hyprbars = {
        #   bar_text_font = "jetbrains mono";
        #   bar_height = 20;
        #   bar_padding = 5;
        #   bar_button_padding = 5;
        #   bar_precedence_over_border = true;
        #   bar_part_of_window = true;
        #   bar_blur = true;
        #   # bar_color = "rgb(1a1b26)";
        #   # col.text = "rgb(c0caf5)";
        #
        #   # example buttons (R -> L)
        #   # hyprbars-button = color, size, on-click
        #   hyprbars-button = [
        #     "rgb(7aa2f7), 13, 󰖭, hyprctl dispatch killactive"
        #     "rgb(7aa2f7), 13, 󰖯, hyprctl dispatch fullscreen 1"
        #     "rgb(7aa2f7), 13, 󰖰, hyprctl dispatch togglefloating"
        #     "rgb(7aa2f7), 13, 󰖰, hyprctl dispatch movetoworkspacesilent special:minimized"
        #   ];
        # };
      };
      plugin = {
        # hyprexpo = {
        #   columns = 3;
        #   gap_size = 5;
        #   # bg_col = "rgb(111111)";
        #   workspace_method = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1
        #
        #   enable_gesture = true; # laptop touchpad
        #   gesture_fingers = 3; # 3 or 4
        #   gesture_distance = 300; # how far is the "max"
        #   gesture_positive = true; # positive = swipe down. Negative = swipe up.
        # };
      };

      decoration = {
        # rounding = 10;
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          new_optimizations = true;
          # ignore_opacity = false;
          xray = true;
        };

        shadow = {
          enabled = false;
          range = 30;
          render_power = 3;
          # color = "0x66000000";
        };

        # Dim
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
      };

      animations = {
        enabled = false;
      };

      monitor = [
        "$mainMonitor,preferred,auto,1,vrr,1"
        "HDMI-A-2,preferred,auto-left,1,vrr,1"
        ",preferred,auto-left,1"
      ];

      "$terminal" = "${run} $TERMINAL";
      "$fileManager" = "${run} $TERMINAL yazi";
      "$menu" = "${toggle "fuzzel"} --launch-prefix='${run}'";

      # exec-once = "$terminal";

      general = {
        layout = "dwindle";
        border_size = 1;
        gaps_out = 0;
        gaps_in = 0;
        resize_on_border = true;
        extend_border_grab_area = 10;
        # Fallback colors
        # "col.inactive_border" = "rgb(414868)";
        # "col.active_border" = "rgb(7aa5f7)";
        no_focus_fallback = true;

        snap = {
          enabled = true;
        };
      };

      # Group settings.
      group = {
        # Whether dragging a window into an unlocked group will merge them.
        # 0 = Disabled | 1 = Enabled | 2 = Only when dragging into the groupbar.
        drag_into_group = 2;

        # Whether window groups can be dragged into other groups.
        merge_groups_on_drag = false;

        # Groupbar settings.
        groupbar = {
          # Height of the groupbar.
          # height = 17;
          # "col.inactive" = "rgb(414868)";
          # Text color of groupbar title.
          # text_color = "rgb(ffffff)";
        };
      };

      exec-once = [
        # "hyprctl setcursor ${cursorName} ${toString pointerSize}"
        "${run} wl-paste --type text --watch cliphist store"
        "${run} wl-paste --type image --watch cliphist store"
        # "${run} flameshot"
      ];

      bind =
        [
          "$mainMod SHIFT, f1, exec, ${run} $HOME/.local/bin/screenON.sh"

          ", XF86Terminal, exec, $terminal"
          ", XF86Calculater, exec, ${lib.getExe pkgs.qalculate-gtk}"
          # ", XF86AudioMedia, exec, ${lib.getExe pkgs.librewolf}"
          ", XF86WWW, exec, ${run} ${lib.getExe pkgs.librewolf}"

          "$mainMod CTRL, Esc, exec, ${run} hyprlock"
          "$mainMod CTRL SHIFT, Esc, exec, ${run} wlogout"

          "$mainMod, B, exec, ${run} ${lib.getExe pkgs.librewolf}"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, R, exec, $menu"
          "$mainMod, T, exec, $terminal"
          "$mainMod, RETURN, exec, $terminal"
          "$mainMod, SPACE, exec, $menu"
          "$mainMod ALT, SPACE, exec, ${run} hyprlist.sh"
          "$mainMod SHIFT, N, exec, ${run} swaync-client -t -sw"
          # "$mainMod N, exec, ${run} makoctl menu fuzzel -d"
          "$mainMod SHIFT, V, exec, ${runOnce "cliphist"} list | fuzzel --dmenu | cliphist decode | wl-copy"

          "$mainMod SHIFT, S, exec, ${run} screenshot window"
          "$mainMod CTRL, S, exec, ${run} screenshot monitor"
          "$mainMod, S, exec, ${run} screenshot region"

          # emoji
          "$mainMod , dot, exec, ${toggle "wofi-emoji"}"

          "$mainMod SHIFT, QUESTION, exec , ${run} hyprbinds.sh"
          "$mainMod SHIFT, A, exec, ${run} correct-clip.sh"

          "$mainMod SHIFT, Q, killactive," # avoid fat finger in $mainMod + 1
          "$mainMod CTRL SHIFT, Q, forcekillactive,"
          "$mainMod SHIFT CTRL, RETURN, fullscreen,"
          "$mainMod SHIFT, RETURN, fullscreen,1"
          "$mainMod, M, layoutmsg, movetoroot"

          "$mainMod, G, togglegroup,"
          "$mainMod SHIFT, N, changegroupactive, f"
          "$mainMod SHIFT, P, changegroupactive, b"
          # "$mainMod, I, changegroupactive, b"
          # "$mainMod, O, changegroupactive, f"

          "$mainMod, V, togglesplit, # dwindle"
          "$mainMod, F, togglefloating,"
          "$mainMod SHIFT, C, resizeactive, exact 60% 70%"
          "$mainMod SHIFT, C, centerwindow,"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod SHIFT CTRL, P, pin" # pin the window
          # "$mainMod SHIFT, P, layoutmsg, movetoroot" # dwindle

          # Move focus focus with mainMod + arrow keys
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod, h, alterzorder, top"
          "$mainMod, l, alterzorder, top"
          "$mainMod, k, alterzorder, top"
          "$mainMod, j, alterzorder, top"

          "$mainMod CTRL SHIFT, h, movewindoworgroup, l"
          "$mainMod CTRL SHIFT, l, movewindoworgroup, r"
          "$mainMod CTRL SHIFT, k, movewindoworgroup, u"
          "$mainMod CTRL SHIFT, j, movewindoworgroup, d"

          "$mainMod SHIFT, h, swapwindow, l"
          "$mainMod SHIFT, l, swapwindow, r"
          "$mainMod SHIFT, k, swapwindow, u"
          "$mainMod SHIFT, j, swapwindow, d"

          "$mainMod ALT, h, resizeactive, -20 0"
          "$mainMod ALT, j, resizeactive, 0 20"
          "$mainMod ALT, k, resizeactive, 0 -20"
          "$mainMod ALT, l, resizeactive, 20 0"

          "$mainMod CTRL ALT, h, moveactive, -100 0"
          "$mainMod CTRL ALT, j, moveactive, 0 100"
          "$mainMod CTRL ALT, k, moveactive, 0 -100"
          "$mainMod CTRL ALT, l, moveactive, 100 0"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod ALT, left, resizeactive, -40 0"
          "$mainMod ALT, right, resizeactive, 0 40"
          "$mainMod ALT, up, resizeactive, 0 -40"
          "$mainMod ALT, down, resizeactive, 40 0"

          "$mainMod, N, movetoworkspace, empty"
          "$mainMod, O, movecurrentworkspacetomonitor,+1"
          "$mainMod SHIFT, O, movewindow, mon:+1"
          "$mainMod, GRAVE, workspace, previous"

          "ALT, tab, cyclenext,"
          "ALT, tab, alterzorder, top"
          "ALT SHIFT, tab, cyclenext, prev"
          "ALT SHIFT, tab, alterzorder, top"
          "$mainMod, tab, focusurgentorlast,"

          # "$mainMod SHIFT, U, movecurrentworkspacetomonitor,+1"
          # "$mainMod SHIFT, D, movecurrentworkspacetomonitor, -1"
          # "$mainMod, U, movewindow, mon:+1"
          # "$mainMod, D, movewindow, mon:-1"

          "$mainMod, Z, togglespecialworkspace, scratchpad"
          "$mainMod SHIFT, Z, movetoworkspace, special:scratchpad"
          "$mainMod SHIFT CTRL, Z, movetoworkspace, e+0"
          # "$mainMod SHIFT CTRL, Z, togglespecialworkspace, minimized"

          "$mainMod, X, togglespecialworkspace, minimized"
          "$mainMod SHIFT, X, movetoworkspacesilent, special:minimized"
          "$mainMod SHIFT CTRL, X, movetoworkspace, e+0"
          # "$mainMod SHIFT CTRL, X, togglespecialworkspace, minimized"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, m+1"
          "$mainMod, mouse_up, workspace, m-1"

          "$mainMod, bracketleft, workspace, m-1"
          "$mainMod, bracketright, workspace, m+1"

          "$mainMod SHIFT, bracketleft, movetoworkspace, m-1"
          "$mainMod SHIFT, bracketright, movetoworkspace, m+1"

        ]
        ++ (
          # workspaces
          # binds $mainMod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        # Requires playerctl
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      windowrulev2 = [
        # Global rules
        "suppressevent maximize, class:.*"
        "opacity 0.95 0.85, fullscreen:0, pinned:0"
        "bordercolor rgba(B6C7E9AA) rgba(B6C7E977), pinned:1"
        # "rounding 10, floating:1"
        # "plugin:hyprbars:nobar, floating:0"

        # Idle inhibition rules
        "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
        "idleinhibit fullscreen, class:^(zen)$"
        "idleinhibit fullscreen, class:^(.*)$"
        "idleinhibit fullscreen, title:^(.*)$"
        "idleinhibit fullscreen, fullscreen:1"

        # Dialog window rules
        "tag +dialog, title:(Open|Choose File|Progress|Save File|Save As)"
        "tag +dialog, title:(Confirm to replace files)"
        "tag +dialog, title:(File Operation Progress)"
        "tag +dialog, class:(librewolf|firefox), title:([sS]ave|[uU]pload)"
        "tag +dialog, class:(xdg-desktop-portal-gtk)"
        "tag +dialog, class:(filechooser)"
        "float, tag:dialog"
        "center, tag:dialog"
        "pin, tag:dialog"
        "noborder, tag:dialog"
        "size 60% 70%, tag:moonlight"

        # File manager and operation dialogs
        "tag +fileops, class:([Tt]hunar), title:(File Operation Progress)"
        "tag +fileops, class:([Tt]hunar), title:(Confirm to replace files)"
        "tag +fileops, class:^(org.kde.dolphin)$, title:^(Progress Dialog — Dolphin)$"
        "tag +fileops, class:^(org.kde.dolphin)$, title:^(Copying — Dolphin)$"
        "tag +fileops, class:(xdg-desktop-portal-gtk)"
        "tag +fileops, class:^(file-roller|org.gnome.FileRoller)$"
        "tag +fileops, class:^([Bb]aobab|org.gnome.[Bb]aobab)$"
        # "tag +fileops, class:^(org.gnome.Nautilus)$"
        "float, tag:fileops"
        "center, tag:fileops"
        "size 60% 70%, tag:fileops"

        # System utilities and settings
        "tag +sysutil, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "tag +sysutil, class:^(nwg-look|qt5ct|qt6ct)$"
        "tag +sysutil, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
        "tag +sysutil, class:.*blueman.*"
        "tag +sysutil, class:^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$"
        "tag +sysutil, class:^(wihotspot(-gui)?)$"
        "tag +sysutil, class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "tag +sysutil, title:(Kvantum Manager)"
        "tag +sysutil, title:^(ROG Control)$"
        "tag +sysutil, title:^(hyprgui)$"
        "tag +sysutil, class:^([Qq]alculate-gtk)$"
        "float, tag:sysutil"
        "center, tag:sysutil"
        "size 70% 70%, tag:sysutil"

        # Media viewers
        # "tag +media, class:^(mpv|com.github.rafostar.Clapper)$"
        # "tag +media, class:^(eog|org.gnome.Loupe)$"
        # "tag +media, class:^(evince)$"
        # "tag +media, class:^(vlc)$"
        # "tag +media, class:^(imv)$"
        "tag +media, title:^(Picture-in-Picture)$"
        "float, tag:media"
        "center, tag:media"
        "size 70% 70%, tag:media"
        "keepaspectratio, title:^(Picture-in-Picture)$"
        "size 25% 25%, title:^(Picture-in-Picture)$"

        # Communication apps
        "tag +comms, class:^([Ww]hatsapp-for-linux)$"
        "tag +comms, class:^([Ff]erdium)$"
        "tag +comms, class:^(Signal)$"
        "tag +comms, class:^(CiscoCollabHost)$"
        "tag +comms, class:Bitwarden"
        "float, tag:comms"
        "center, tag:comms"
        "size 60% 70%, tag:comms"
        "size 25% 25%, class:^(CiscoCollabHost)$, title:^(Welcome to Webex -  Webex)$"

        # Browser-specific
        "tag +browser_dialog, class:^(firefox)$, title:^(Picture-in-Picture)$"
        "tag +browser_dialog, class:^(firefox)$, title:^(Library)$"
        "tag +browser_dialog, title:^(About Mozilla Firefox)$"
        "tag +browser_dialog, title:^(Sign in)$"
        "float, tag:browser_dialog"
        "center, tag:browser_dialog"

        # Workspace assignments
        "workspace 5 silent, class:^([wl|x]freerdp)$"
        "workspace 6 silent, class:^(Mattermost)$"
        "workspace 7 silent, class:^(vesktop)$"

        # Virt manager
        "tag +virt-manager, class:^(.virt-manager-wrapped)$"
        "group, always, tag:virt-manager"
        "workspace 4, tag:virt-manager"
        # "group, always, class: (.virt-manager-wrapped), title:(Virtual Machine Manager)"

        # Moonlight
        "tag +moonlight, class:^(com.moonlight_stream.Moonlight)$"
        "center, tag:moonlight"
        "float, tag:moonlight"
        "size 25% 50%, tag:moonlight"
        "workspace 5, tag:moonlight"

        # Special workspace styles
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"

        # XWayland fixes
        "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
        "opacity 1 overide 1 overide 1 overide, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
        "noblur, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
      ];

      workspace = [
        # "1,monitor:$mainMonitor,default:true"
        # "2,monitor:$mainMonitor"
        # "3,monitor:$mainMonitor"
        # "4,monitor:$mainMonitor"
        # "5,monitor:$mainMonitor"
        # "6,monitor:$mainMonitor"

        # smartgaps trick see wiki workspace-rules
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      layerrule = [
        "blur,launcher" # fuzzel
        "ignorezero,launcher"

        "blur,notification" # dunst
        "ignorezero,notification"

        "blur,swaync-control-center"
        "ignorezero,swaync-control-center"
        "blur,swaync-notification-window"
        "ignorezero,swaync-notification-window"

        "blur,logout_dialog"
        "blur,waybar"
      ];

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      misc = {

        # disable_loading_bar = true;
        # no_fade_in = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0; # disable default wallpaper
        vfr = true;
        focus_on_activate = false;
      };

      #
      master = {
        new_status = "master";
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification
        # kb_options = "ctrl:nocaps";
        scroll_factor = 2.0;
        touchpad = {
          natural_scroll = false;
          disable_while_typing = true;
          middle_button_emulation = true;
          tap-to-click = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

    };

    extraConfig = ''
      $reset = hyprctl dispatch submap reset 

      # Passthrough mode
      bind=$mainMod , Escape,submap,passthrough
      submap=passthrough
      bind=$mainMod , Escape,submap,reset
      submap=reset

      # Window mode
      # bind = $mainMod, W, exec, sleep 2 && $reset
      bind = $mainMod, W, submap, window 

      submap = window 
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10

      binde = shift, right, moveactive, 10 0
      binde = shift, left, moveactive, -10 0
      binde = shift, up, moveactive, 0 -10
      binde = shift, down, moveactive, 0 10

      bind = , Q, killactive,
      bind = SHIFT, Q, forcekillactive,
      bind = , RETURN, fullscreen,
      bind = SHIFT, RETURN, fullscreen,1
      bind = , M, layoutmsg, movetoroot,


      # use reset to go back to the global submap
      bind = , escape, submap, reset

      # will reset the submap, which will return to the global submap
      submap = reset
    '';
  };
}
