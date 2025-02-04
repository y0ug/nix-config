{ pkgs, ... }:
let
  # toggle = app: "pkill ${app} || uwsm app -u ${app}.scope -- ${app}";
  # runOnce = app: "pgrep ${app} || uwsm app -- ${app}";
  # toggle = app: "systemctl --user stop ${app}.scope || uwsm app -u ${app}.scope -- ${app}";
  toggle = app: "pkill ${app} || uwsm app -u ${app}.scope -- ${app}";
  runOnce = app: "uwsm app -u ${app}.scope -- ${app}";
  run = "uwsm app --";
  cursorName = "Bibata-Modern-Classic";
  pointerSize = 16;
in
{

  # wayland.windowManager.hyprland.plugins = [
  #   # pkgs.hyprlandPlugins.hy3
  # ];

  # home-manager.users.rick.wayland.windowManager.hyprland.settings.exec-once = [
  #   "systemctl --user start hyprpolkitagent"
  # ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "TERMINAL,kitty"
      # "HYPRCURSOR_THEME,${cursorName}"
      # "HYPRCURSOR_SIZE,${toString pointerSize}"
    ];

    "$mainMod" = "SUPER";

    "$mainMonitor" = "DP-1";

    monitor = [
      "$mainMonitor,preferred,auto,1,vrr,1"
      "HDMI-A-2,preferred,auto-left,1,vrr,1"
      ",preferred,auto-left,1"
    ];

    "$terminal" = "${run} kitty";
    "$fileManager" = "$terminal ${run} yazi";
    "$menu" = "${toggle "fuzzel"} --launch-prefix='${run}'";

    # exec-once = "$terminal";

    general = {
      #   layout = "master";
      border_size = 2;
      gaps_out = 0;
      gaps_in = 0;
    };

    exec-once = [
      "hyprctl setcursor ${cursorName} ${toString pointerSize}"
      "${runOnce "wl-paste"} --type text --watch cliphist store"
    ];

    bind =
      [
        "$mainMod SHIFT, f1, exec, ${run} $HOME/.local/bin/screenON.sh"
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod SHIFT, Escape, exec, ${run} wlogout"
        "$mainMod CTRL, L, exec, ${runOnce "hyprlock"}"

        "$mainMod, E, exec, $fileManager"
        "$mainMod, SPACE, exec, $menu"

        "$mainMod, V, exec, ${runOnce "cliphist"} list | fuzzel --dmenu | cliphist decode | wl-copy"

        # Screenshot a window
        "$mainMod SHIFT, W, exec, ${runOnce "hyprshot"} -m window"
        # Screenshot a monitor
        "$mainMod SHIFT, M, exec, ${runOnce "hyprshot"} -m output"
        # Screenshot a region
        "$mainMod SHIFT, S, exec, ${runOnce "hyprshot"} -m region"

        "$mainMod SHIFT, n, exec, ${runOnce "swaync-client"} -t -sw"

        # emoji
        "$mainMod SHIFT, E, exec, ${toggle "wofi-emoji"}"

        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, F, fullscreen,"
        "$mainMod, M, fullscreen,1"

        "$mainMod, G, togglegroup,"
        "$mainMod SHIFT, N, changegroupactive, f"
        "$mainMod SHIFT, P, changegroupactive, b"
        # "$mainMod, I, changegroupactive, b"
        # "$mainMod, O, changegroupactive, f"

        "$mainMod, S, togglesplit, # dwindle"
        "$mainMod, F, togglefloating,"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod SHIFT, Y, pin" # pin the window
        # "$mainMod SHIFT, P, layoutmsg, movetoroot" # dwindle

        # Move focus focus with mainMod + arrow keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        "$mainMod, N, movetoworkspace, empty"
        "$mainMod, backslash, workspace, previous"

        "ALT, tab, cyclenext,"
        "ALT, tab, alterzorder, top"
        "ALT SHIFT, tab, cyclenext, prev"
        "ALT SHIFT, tab, alterzorder, top"
        "$mainMod, tab, focusurgentorlast,"

        "$mainMod , period, movecurrentworkspacetomonitor,+1"
        "$mainMod , coma, movecurrentworkspacetomonitor, -1"
        "$mainMod SHIFT, period, movewindow, mon:+1"
        "$mainMod SHIFT, coma, movewindow, mon:-1"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, r+1"
        "$mainMod, mouse_up, workspace, r-1"

        "$mainMod, bracketleft, workspace, r-1"
        "$mainMod, bracketright, workspace, r+1"

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
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      # idle inhibit while watching videos
      "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
      "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(zen)$"

      # Bitwarden extension
      "float, class:Bitwarden"
      "size 50% 50%, class:Bitwarden"
      "move 25% 25%, class:Bitwarden"

      # gnome calculator
      "float, class:^(org.gnome.Calculator)$"
      "size 360 490, class:^(org.gnome.Calculator)$"

      # "float, class:^(pavucontrol)$"
      # "size 86% 40%, class:^(pavucontrol)$"
      # "move 50% 6%, class:^(pavucontrol)$"
      # "workspace special silent, class:^(pavucontrol)$"
      # "opacity 0.80, class:^(pavucontrol)$"
      # "minsize 20%, floating:1"

      # "float,class:.*blueman.*"

      "size 25% 25%,class:.*pavucontrol.*"
      "move 25% 25%,class:.*pavucontrol.*"

      # "workspace special:config,class:.*blueman.*"
      # "workspace special:config,class:.*pavucontrol.*"

      # smartgaps trick see wiki workspace-rules
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"

      "tile, class:^(xfreerdp)$"
      "workspace name:RDP, class:^wlfreerdp$"
      "workspace name:RDP, class:^xfreerdp$"

      "float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$"
      "float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$"
      "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"

      "float,title:^(About Mozilla Firefox)$"
      "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
      "float,class:^(firefox)$,title:^(Library)$"
      "float,class:^(vlc)$"
      "float,class:^(qt5ct)$"
      "float,class:^(qt6ct)$"
      "float,class:^(org.pulseaudio.pavucontrol)$"

      "opacity 0.80 0.70,class:^(org.pulseaudio.pavucontrol)$"
      "opacity 0.80 0.70,class:.*blueman.*"
      "opacity 0.80 0.70,class:^(nm-applet)$"
      "opacity 0.80 0.70,class:^(nm-connection-editor)$"
      "opacity 0.80 0.70,class:^(polkit-gnome-authentication-agent-1)$"

      "float,class:.*blueman.*"
      "float,class:^(nm-applet)$"
      "float,class:^(nm-connection-editor)$"
      "float,class:^(Signal)$ # Signal-Gtk"
      "float,class:^(eog)$ # Imageviewer-Gtk"
      "float,class:^(io.missioncenter.MissionCenter)$ # MissionCenter-Gtk"
      "float,class:^(io.gitlab.adhami3310.Impression)$ # Impression-Gtk"

      "size 25% 25%,class:.*blueman.*"
      "move 25% 25%,class:.*blueman.*"
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
      "1,monitor:$mainMonitor,default:true"
      "2,monitor:$mainMonitor"
      "3,monitor:$mainMonitor"
      "4,monitor:$mainMonitor"
      "5,monitor:$mainMonitor"
      "6,monitor:$mainMonitor"

      # smartgaps trick see wiki workspace-rules
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];

    layerrule = [
      "blur,launcher" # fuzzel
      "ignorezero,launcher"
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

    decoration = {
      blur.enabled = true;
      shadow.enabled = true;
    };

    master = {
      new_status = "master";
    };

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      sensitivity = 0; # -1.0 - 1.0, 0 means no modification
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

  wayland.windowManager.hyprland.extraConfig = ''
    # Passthrough mode
    # bind=$mainMod SHIFT, P,submap,passthrough
    # submap=passthrough
    # bind=$mainMod SHIFT, P,submap,reset
    # submap=reset
  '';
}
