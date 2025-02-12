{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    # themeFile = "gruvbox-dark";

    extraConfig = ''
      include ${../../themes/tokyonight/kitty/tokyonight_night.conf}

      # kitty-scrollback.nvim Kitten alias
      action_alias kitty_scrollback_nvim kitten /home/rick/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py

      # Browse scrollback buffer in nvim
      map kitty_mod+h kitty_scrollback_nvim
      # Browse output of the last shell command in nvim
      map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
      # Show clicked command output in nvim
      mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
    '';

    # font = {
    #   name = "JetBrainsMono Nerd Font";
    #   size = 12;
    # };

    shellIntegration.mode = "enabled";
    settings = {
      # shell = "/usr/bin/env sh -c \"tmux new-session -s kitty_$(date +%s)\"";
      # shell = "tmux new-session -As kitty \; new-window";

      # background_opacity = "0.90";
      window_padding_width = 5;
      scrollback_lines = 10000;
      mouse_hide_wait = 60;

      # confirm_os_window_close = 0;
      close_on_child_death = true;
      allow_remote_control = "socket-only";
      listen_on = if pkgs.stdenv.isLinux then "unix:@kitty" else "unix:/tmp/kitty";

      enabled_layouts = "splits,fat";
      # enabled_layouts = "";

      notify_on_cmd_finish = "invisible 5.0 command notify-send \"job finished with status: %s\" %c";

      # shell_integration = "enabled";

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
      visual_bell_duration = 0.2;
      window_alert_on_bell = true;

      # kitty_mod = "ctrl+shift";
      clear_all_shortcuts = false;
    };

    # tmux bindings
    keybindings = {
      # Key Mappings (Default kitty_mod is ctrl+shift)
      # "ctrl+c" = "copy_to_clipboard";
      # "ctrl+v" = "paste_from_clipboard";
      # "ctrl+s" = "paste_from_selection";
      # "ctrl+o" = "pass_selection_to_program";
      #
      # Windows
      # "kitty_mod+c" = "new_window";
      # "kitty_mod+." = "previous_window";
      # "kitty_mod+<" = "next_window";
      # "kitty_mod+x" = "close_window";
      #
      # # Tab Navigation
      # "kitty_mod+t" = "new_tab";
      # "kitty_mod+[" = "previous_tab";
      # "kitty_mod+]" = "next_tab";
      # "kitty_mod+q" = "close_tab";
      # "kitty_mod+f" = "toggle_fullscreen";
      # "kitty_mod+\\" = "goto_tab -1";
      #
      # # come from vim/emacs
      # "kitty_mod+i" = "scroll_line_up";
      # "kitty_mod+n" = "scroll_line_down";
      # "kitty_mod+;" = "scroll_page_up";
      # "kitty_mod+'" = "scroll_page_down";
      #
      # "kitty_mod+home" = "scroll_home";
      # "kitty_mod+end" = "scroll_end";
      #
      # # Split View Controls
      # "kitty_mod+%" = "launch --location=hsplit"; # %
      # "kitty_mod+\"" = "launch --location=vsplit";
      #
      # "kitty_mod+space" = "layout_action rotate";
      #
      # # Pane Navigation
      # "kitty_mod+h" = "neighboring_window left";
      # "kitty_mod+l" = "neighboring_window right";
      # "kitty_mod+k" = "neighboring_window up";
      # "kitty_mod+j" = "neighboring_window down";

      # Pane Resizing
      #"kitty_mod+shift+h" = "resize_window narrower 20";
      #"kitty_mod+shift+l" = "resize_window wider 20";
      #"kitty_mod+shift+k" = "resize_window taller 20";
      #"kitty_mod+shift+j" = "resize_window shorter 20";

    };
  };
}
