{ config, pkgs, ... }:

{
  imports = [./wezterm.nix];

  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };


  wayland.windowManager.hyprland.settings = {
      "$MOD" = "SUPER";
      env = [
        # NIXOS Environment Variable
        "NIXOS_OZONE_WL, 1"  # Wayland support in Chromium and Electron
        # Hyprland Environment Variables
        # Toolkit Backend Variables
        "GDK_BACKEND, wayland,x11"  # GTK: Use wayland if available, fall back to x11 if not.
        "QT_QPA_PLATFORM, wayland;xcb"  # Qt: Use wayland if available, fall back to x11 if not.
        "SDL_VIDEODRIVER, wayland"  # Run SDL2 applications on Wayland. Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
        "CLUTTER_BACKEND, wayland"  # Clutter package already has wayland enabled, this variable will force Clutter applications to try and use the Wayland backend
        # XDG Specifications
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        # Qt Variables
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"  # (From the Qt documentation) enables automatic scaling, based on the monitor’s pixel density
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"  # Disables window decorations on Qt applications
        "QT_QPA_PLATFORMTHEME, qt5ct"  # Tells Qt based applications to pick your theme from qt5ct, use with Kvantum.
        # NVIDIA Specific
        #"LIBVA_DRIVER_NAME, nvidia"  # Hardware acceleration on NVIDIA GPUs
        # Theming Related Variables
        #"GTK_THEME"  # Set a GTK theme manually, for those who want to avoid appearance tools such as lxappearance or nwg-look
        #"XCURSOR_THEME"  # Set your cursor theme. The theme needs to be installed and readable by your user.
        # "XCURSOR_SIZE"  # Set cursor size. See here for why you might want this variable set.
        "MOZ_ENABLE_WAYLAND, 1"  # irefox with Wayland
        # vm "WLR_NO_HARDWARE_CURSORS,1"
        # VM "WLR_RENDERER_ALLOW_SOFTWARE,1"
        # nivida "WLR_NO_HARDWARE_CURSORS,1"
      ];
  };
}
