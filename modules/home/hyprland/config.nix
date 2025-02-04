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

    monitor = [
      "DP-1,preferred,auto,1,vrr,1"
      "HDMI-A-2,preferred,auto-left,1,vrr,1"
      ",preferred,auto-left,1"
    ];

    "$terminal" = "${run} kitty";
    "$fileManager" = "$terminal ${run} yazi";
    "$menu" = "${toggle "fuzzel"} --launch-prefix='${run}'";

    # exec-once = "$terminal";

    general = {
      #   layout = "master";
      border_size = 1;
      gaps_out = 10;
      gaps_in = 2;
    };

    exec-once = [
      "hyprctl setcursor ${cursorName} ${toString pointerSize}"
      "${runOnce "wl-paste"} --type text --watch cliphist store"
    ];

    bind =
      [
        "$mainMod SHIFT, 1, exec, ${run} $HOME/.local/bin/screenON.sh"
        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen,"
        "$mainMod, M, fullscreen,1"

        # "$mainMod, G, tooglegroup,"
        # "$mainMod SHIFT, N, changegroupactive, f"
        # "$mainMod SHIFT, P, changegroupactive, b"

        "$mainMod, S, togglesplit, # dwindle"
        "$mainMod, T, togglefloating,"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod SHIFT, P, pin" # pin the window
        # "$mainMod SHIFT, P, layoutmsg, movetoroot" # dwindle

        "$mainMod ALT,, resizeactive"

        "$mainMod, RETURN, exec, $terminal"
        "$mainMod SHIFT, Escape, exit,"

        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $menu"

        "$mainMod, V, exec, ${runOnce "cliphist"} list | $menu --dmenu | cliphist decode | wl-copy"

        # Move focus focus with mainMod + arrow keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        "$mainMod, Escape, exec, ${runOnce "hyprlock"}"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, Tab, workspace, m+1"
        "$mainMod SHIFT, Tab, workspace, m-1"

        # Screenshot a window
        "$mainMod SHIFT, W, exec, ${runOnce "hyprshot"} -m window"
        # Screenshot a monitor
        "$mainMod SHIFT, M, exec, ${runOnce "hyprshot"} -m output"
        # Screenshot a region
        "$mainMod SHIFT, S, exec, ${runOnce "hyprshot"} -m region"

        "$mainMod SHIFT, n, exec, ${runOnce "swaync-client"} -t -sw"

        # emoji
        "$mainMod SHIFT, E, exec, ${toggle "wofi-emoji"}"
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

      "minsize 30%, floating:1"

      # gnome calculator
      "float, class:^(org.gnome.Calculator)$"
      "size 360 490, class:^(org.gnome.Calculator)$"

      # "float, class:^(pavucontrol)$"
      # "size 86% 40%, class:^(pavucontrol)$"
      # "move 50% 6%, class:^(pavucontrol)$"
      # "workspace special silent, class:^(pavucontrol)$"
      # "opacity 0.80, class:^(pavucontrol)$"
      # "minsize 20%, floating:1"

      "opacity 0.85,class:^(fuzzel)$"
      "float,class:.*blueman.*"
      "size 25% 25%,class:.*blueman.*"
      "move 25% 25%,class:.*blueman.*"

      "float,class:.*pavucontrol.*"
      "size 25% 25%,class:.*pavucontrol.*"
      "move 25% 25%,class:.*pavucontrol.*"

      "float, class:^(firefox)$, title:^(Sign In)$"
      "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
      "float, class:^(firefox)$, title:^(Library)$"
      "float, class:^(firefox)$, title:.*Bitwarden Password Manager.*"
      # "workspace special:config,class:.*blueman.*"
      # "workspace special:config,class:.*pavucontrol.*"

      # smartgaps trick see wiki workspace-rules
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"
    ];

    workspace = [

      # smartgaps trick see wiki workspace-rules
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];

    dwindle = {
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # you probably want this
    };

    misc = {
      force_default_wallpaper = 0;
      # disable_hyprland_logo = true
      vfr = true;
      focus_on_activate = true;
      # Fix some windows opening on workspace 1
      initial_workspace_tracking = false;
    };

    decoration = {
      blur.enabled = false;
      shadow.enabled = false;
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
      };
    };

    gestures = {
      workspace_swipe = false;
    };

  };
}
