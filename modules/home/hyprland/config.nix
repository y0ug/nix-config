{ inputs, pkgs, ... }:
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
          sensitivity = -1;
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
        rounding = 10;
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
          enabled = true;
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

      "$terminal" = "${run} kitty";
      "$fileManager" = "${run} nautilus";
      "$menu" = "${toggle "fuzzel"} --launch-prefix='${run}'";

      # exec-once = "$terminal";

      general = {
        layout = "dwindle";
        border_size = 1;
        gaps_out = 4;
        gaps_in = 5;
        resize_on_border = true;
        # Fallback colors
        # "col.inactive_border" = "rgb(414868)";
        # "col.active_border" = "rgb(7aa5f7)";
        no_focus_fallback = true;

        snap = {
          enabled = true;
        };
      };

      exec-once = [
        # "hyprctl setcursor ${cursorName} ${toString pointerSize}"
        "${run} wl-paste --type text --watch cliphist store"
        "${run} wl-paste --type image --watch cliphist store"
        "${run} flameshot"
      ];

      bind =
        [
          "$mainMod SHIFT, f1, exec, ${run} $HOME/.local/bin/screenON.sh"
          "$mainMod,RETURN, exec, $terminal"
          "$mainMod CTRL, L, exec, ${run} hyprlock"
          # "$mainMod SHIFT, Escape, exec, ${run} wlogout"

          "$mainMod, E, exec, $fileManager"
          "$mainMod, R, exec, $menu"
          "$mainMod, SPACE, exec, $menu"

          # "$mainMod, equal, hyprexpo:expo, toggle"
          "$mainMod SHIFT, V, exec, ${runOnce "cliphist"} list | fuzzel --dmenu | cliphist decode | wl-copy"

          # Screenshot a window
          # "$mainMod, PRINT, exec, ${run} hyprshot -m window"
          # Screenshot a monitor
          # ", PRINT, exec, ${run} hyprshot -m output"
          ", PRINT, exec, ${run} flameshot gui"
          # Screenshot a region
          # "$mainMod SHIFT, PRINT, exec, ${run} hyprshot -m region"

          "$mainMod SHIFT, n, exec, ${run} swaync-client -t -sw"
          # "$mainMod SHIFT, N, exec, ${run} makoctl menu fuzzel -d"

          # emoji
          "$mainMod SHIFT, E, exec, ${toggle "wofi-emoji"}"

          "$mainMod SHIFT, DOT, exec , ${run} hyprbinds.sh"
          "$mainMod, A, exec, ${run} correct-clip.sh"

          "$mainMod, Q, killactive,"
          "$mainMod SHIFT, Q, forcekillactive,"
          "$mainMod SHIFT, F, fullscreen,"
          "$mainMod SHIFT, M, fullscreen,1"
          "$mainMod, M, layoutmsg, movetoroot"

          "$mainMod, G, togglegroup,"
          "$mainMod SHIFT, N, changegroupactive, f"
          "$mainMod SHIFT, P, changegroupactive, b"
          # "$mainMod, I, changegroupactive, b"
          # "$mainMod, O, changegroupactive, f"

          "$mainMod, V, togglesplit, # dwindle"
          "$mainMod, F, togglefloating,"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod SHIFT, Y, pin" # pin the window
          # "$mainMod SHIFT, P, layoutmsg, movetoroot" # dwindle

          # Move focus focus with mainMod + arrow keys
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod SHIFT, h, movewindoworgroup, l"
          "$mainMod SHIFT, l, movewindoworgroup, r"
          "$mainMod SHIFT, k, movewindoworgroup, u"
          "$mainMod SHIFT, j, movewindoworgroup, d"

          "$mainMod ALT, h, resizeactive, -40 0"
          "$mainMod ALT, j, resizeactive, 0 40"
          "$mainMod ALT, k, resizeactive, 0 -40"
          "$mainMod ALT, l, resizeactive, 40 0"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"

          "$mainMod ALT, left, resizeactive, -40 0"
          "$mainMod ALT, right, resizeactive, 0 40"
          "$mainMod ALT, up, resizeactive, 0 -40"
          "$mainMod ALT, down, resizeactive, 40 0"

          "$mainMod SHIFT, O, movetoworkspace, empty"
          "$mainMod , O, movecurrentworkspacetomonitor,+1"
          "$mainMod, backslash, workspace, previous"

          "ALT, tab, cyclenext,"
          "ALT, tab, alterzorder, top"
          "ALT SHIFT, tab, cyclenext, prev"
          "ALT SHIFT, tab, alterzorder, top"
          "$mainMod, tab, focusurgentorlast,"

          "$mainMod SHIFT, period, movecurrentworkspacetomonitor,+1"
          "$mainMod SHIFT, comma, movecurrentworkspacetomonitor, -1"
          "$mainMod , period, movewindow, mon:+1"
          "$mainMod , comma, movewindow, mon:-1"

          # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          "$mainMod, minus, togglespecialworkspace, minimized"
          "$mainMod SHIFT, minus, movetoworkspace, special:minimized"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, m+1"
          "$mainMod, mouse_up, workspace, m-1"

          "$mainMod, bracketleft, workspace, m-1"
          "$mainMod, bracketright, workspace, m+1"

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
        # Ignore maximize requests from apps
        "suppressevent maximize, class:.*"

        # changed pined border
        "bordercolor rgba(B6C7E9AA) rgba(B6C7E977),pinned:1"

        # enable hyprbars on floating only
        "plugin:hyprbars:nobar,floating:0"

        # idle inhibit while watching videos
        "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
        "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(zen)$"

        # windowrule v2 to avoid idle for fullscreen apps
        " idleinhibit fullscreen, class:^(.*)$"
        " idleinhibit fullscreen, title:^(.*)$"
        " idleinhibit fullscreen, fullscreen:1"

        "float, class:Bitwarden"
        " float, class:^(org.kde.polkit-kde-authentication-agent-1)$ "
        " float, class:([Zz]oom|onedriver|onedriver-launcher)$"
        " float, class:([Tt]hunar), title:(File Operation Progress)"
        " float, class:([Tt]hunar), title:(Confirm to replace files)"
        " float, class:(xdg-desktop-portal-gtk)"
        " float, class:(org.gnome.Calculator), title:(Calculator)"
        " float, class:(codium|codium-url-handler|VSCodium|code-oss), title:(Add Folder to Workspace)"
        " float, class:(electron), title:(Add Folder to Workspace)"
        " float, class:^(eog|org.gnome.Loupe)$ # image viewer"
        " float, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        " float, class:^(nwg-look|qt5ct|qt6ct)$"
        " float, class:^(mpv|com.github.rafostar.Clapper)$"
        " float, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
        " float, class:^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$ # system monitor"
        " float, class:^(wihotspot(-gui)?)$ # wifi hotspot"
        " float, class:^(evince)$ # document viewer"
        " float, class:^(file-roller|org.gnome.FileRoller)$ # archive manager"
        " float, class:^([Bb]aobab|org.gnome.[Bb]aobab)$ # Disk usage analyzer"
        " float, title:(Kvantum Manager)"
        " float, class:^([Ss]team)$,title:^([Ss]team .*)$"
        " float, class:^([Qq]alculate-gtk)$"
        " float, class:^([Ww]hatsapp-for-linux)$"
        " float, class:^([Ff]erdium)$"
        " float, title:^(Picture-in-Picture)$"
        " float, title:^(ROG Control)$"
        " float, title:^(hyprgui)$"

        "float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$"
        "float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$"
        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"

        "float,title:^(About Mozilla Firefox)$"
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "float,class:^(firefox)$,title:^(Library)$"
        "float,title:^(Sign in)$"
        "float,class:^(vlc)$"
        "float,class:^(qt5ct)$"
        "float,class:^(qt6ct)$"
        "float,class:^(org.pulseaudio.pavucontrol)$"
        "float,class:^(nwg-look)$"
        "float,class:^(\.virt-manager-wrapped)$"
        "float,class:^(org.gnome.Nautilus)$"
        "float,class:.*blueman.*"
        "float,class:^(nm-applet)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(Signal)$ # Signal-Gtk"
        "float,class:^(eog)$ # Imageviewer-Gtk"
        "float,class:^(io.missioncenter.MissionCenter)$ # MissionCenter-Gtk"
        "float,class:^(io.gitlab.adhami3310.Impression)$ # Impression-Gtk"
        "float,class:^(imv)$"
        "size 60% 70%,floating:1"
        "float,class:^(CiscoCollabHost)$,title:^(Welcome to Webex -  Webex)$"
        "size 25% 25%, class:^(CiscoCollabHost)$,title:^(Welcome to Webex -  Webex)$"

        "float,class:^(org.keepassxc.KeePassXC)$"
        "size 25% 25%,class:^(org.keepassxc.KeePassXC)$"

        " size 70% 70%, class:^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$"
        " size 70% 70%, class:^(xdg-desktop-portal-gtk)$"
        " size 60% 70%, title:(Kvantum Manager)"
        " size 60% 70%, class:^(qt6ct)$"
        " size 70% 70%, class:^(evince|wihotspot(-gui)?)$"
        " size 60% 70%, class:^(file-roller|org.gnome.FileRoller)$"
        " size 60% 70%, class:^([Ww]hatsapp-for-linux)$"
        " size 60% 70%, class:^([Ff]erdium)$"
        " size 60% 70%, title:^(ROG Control)$"
        " size 25% 25%, title:^(Picture-in-Picture)$   "
        " size 60% 70%, title:^(hyprgui)$"
        "size 60%, 70% class:Bitwarden"
        "size 50%, 50%,class:^(org.gnome.Nautilus)$"

        " keepaspectratio, title:^(Picture-in-Picture)$"

        # smartgaps trick see wiki workspace-rules
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"

        "workspace 5 silent, class:^([wl|x]freerdp)$"
        "workspace 5, class:^(com.moonlight_stream.Moonlight)$"
        "float, class:^(com.moonlight_stream.Moonlight)$,title:^(Moonlight)$"
        "size 25% 50%, class:^(com.moonlight_stream.Moonlight)$,title:^(Moonlight)$"
        "workspace 6 silent, class:^(Mattermost)$"
        "workspace 7 silent, class:^([vesktop)$"

        # "opacity 0.95 0.85 ,class:^(kitty)$,"
        "opacity 0.95 0.85 ,fullscreen:0, pinned:0"

        "rounding 10,floating:1"
        "bordersize 1,floating:1"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # Fix mattermost menu that does not have a class and don't render blur correctly
        "opacity 1 overide 1 overide 1 overide,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "noblur,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      windowrule = [
        # common modals
        "float,title:^(Open)$"
        "float,title:^(Choose Files)$"
        "float,title:^(Save As)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
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
      # Passthrough mode
      bind=$mainMod , Escape,submap,passthrough
      submap=passthrough
      bind=$mainMod , Escape,submap,reset
      submap=reset
    '';
  };
}
