{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    # themeFile = "gruvbox-dark";

    extraConfig = ''
      include ${../../themes/tokyonight/kitty/tokyonight_night.conf}
    '';

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };

    settings = {
      background_opacity = "0.90";
      window_padding_width = 5;
      scrollback_lines = 10000;
      mouse_hide_wait = 60;

      # confirm_os_window_close = 0;
      close_on_child_death = true;
      allow_remote_control = "socket-only";
      listen_on = if pkgs.stdenv.isLinux then "unix:@kitty" else "unix:/tmp/kitty";

      enabled_layouts = "splits,fat";

      ### Tabs
      # tab_powerline_style = "round";
      placement_strategy = "center";
      # tab_bar_style = "fade";
      tab_bar_style = "powerline";
      tab_bar_edge = "top";

      # clipboard
      copy_on_select = true;
      # strip_trailing_spaces = "smart";
      select_by_word_characters = "@-./_~?&=%+#";

      # Audio and Visual Bell
      enable_audio_bell = false;
      visual_bell_duration = 0.1;
      window_alert_on_bell = true;
      kitty_mod = "ctrl+alt";
    };

    # tmux bindings
    keybindings = {
      # Key Mappings (Default kitty_mod is ctrl+shift)
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "ctrl+shift+o" = "pass_selection_to_program";

      # Windows
      "kitty_mod+c" = "new_window";
      "kitty_mod+;" = "previous_window";
      "kitty_mod+o" = "next_window";
      "kitty_mod+x" = "close_window";
      # "kiity_mod+;" = ""; # previous windows?

      # Tab Navigation
      "kitty_mod+t" = "new_tab";
      "kitty_mod+n" = "previous_tab";
      "kitty_mod+p" = "next_tab";
      "kitty_mod+&" = "close_tab";
      "kitty_mod+z" = "toggle_fullscreen";
      "kitty_mod+\\" = "goto_tab -1";

      # come from vim/emacs
      # "kitty_mod+i" = "scroll_line_up";
      # "kitty_mod+n" = "scroll_line_down";
      "kitty_mod+u" = "scroll_page_up";
      "kitty_mod+d" = "scroll_page_down";

      "kitty_mod+home" = "scroll_home";
      "kitty_mod+end" = "scroll_end";

      # Split View Controls
      "kitty_mod+s" = "launch --location=hsplit"; # %
      "kitty_mod+v" = "launch --location=vsplit";

      "kitty_mod+space" = "layout_action rotate";

      # Pane Navigation
      "kitty_mod+h" = "neighboring_window left";
      "kitty_mod+l" = "neighboring_window right";
      "kitty_mod+k" = "neighboring_window up";
      "kitty_mod+j" = "neighboring_window down";

      # Pane Resizing
      "kitty_mod+ctrl+h" = "resize_window narrower 20";
      "kitty_mod+ctrl+l" = "resize_window wider 20";
      "kitty_mod+ctrl+k" = "resize_window taller 20";
      "kitty_mod+ctrl+j" = "resize_window shorter 20";

      # Closing Panes
      "kitty_mod+w" = "close_window";
    };
  };
}
