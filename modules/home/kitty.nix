{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    # themeFile = "gruvbox-dark";

    # include ${../../themes/tokyonight/kitty/tokyonight_night.conf}
    extraConfig = ''
      symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono

      # kitty-scrollback.nvim Kitten alias
      action_alias kitty_scrollback_nvim kitten /home/rick/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py

      # Browse scrollback buffer in nvim
      map kitty_mod+h kitty_scrollback_nvim
      # Browse output of the last shell command in nvim
      map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
      # Show clicked command output in nvim
      mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output


      # tmux settings
      map ctrl+a>r load_config_file
      # Make ctrl+a ctrl+a to send ctrl+a
      map ctrl+a>ctrl+a send_text all \x01
      map ctrl+shift+2 send_text all \x00

      ### Layout operations ###
      # stack layout behaves the same as tmux pane zoom
      enabled_layouts splits,stack
      map ctrl+a>z toggle_layout stack
      map ctrl+a>space layout_action rotate

      ### Tab operations, corresponds to tmux window ###
      map ctrl+a>c new_tab
      map ctrl+a>& close_tab
      map ctrl+a>s new_tab_with_cwd

      map ctrl+a>w select_tab
      map ctrl+a>n next_tab
      map ctrl+a>p previous_tab
      map ctrl+a>0 goto_tab 1
      map ctrl+a>1 goto_tab 2
      map ctrl+a>2 goto_tab 3
      map ctrl+a>3 goto_tab 4
      map ctrl+a>4 goto_tab 5
      map ctrl+a>5 goto_tab 6
      map ctrl+a>6 goto_tab 7
      map ctrl+a>7 goto_tab 8
      map ctrl+a>8 goto_tab 9
      map ctrl+a>9 goto_tab 10

      # tmux sensible keybinding
      map ctrl+a>ctrl+p previous_tab
      map ctrl+a>ctrl+n next_tab

      ### Window operations, corresponds to tmux pane ###
      map ctrl+a>" launch --location=hsplit --cwd=current
      map ctrl+a>% launch --location=vsplit --cwd=current

      map ctrl+a>x close_window
      map ctrl+a>f new_window_with_cwd

      map ctrl+a>q focus_visible_window
      map ctrl+a>o next_window

      map ctrl+a>up neighboring_window up
      map ctrl+a>down neighboring_window down
      map ctrl+a>left neighboring_window left
      map ctrl+a>right neighboring_window right

      map ctrl+a>k neighboring_window up
      map ctrl+a>j neighboring_window down
      map ctrl+a>h neighboring_window left
      map ctrl+a>l neighboring_window right

      ### hints kitten ###
      # Open file or url
      map ctrl+a>h>f kitten hints --type=linenum --linenum-action=tab nvim +{line} {path}
      map ctrl+a>h>u open_url_with_hints
      # Insert text directly
      map ctrl+a>h>p kitten hints --type=path --program=-
      map ctrl+a>h>w kitten hints --type=word --program=-
      map ctrl+a>h>h kitten hints --type=hash --program=-
      # Copy text to clipboard
      map ctrl+a>h>l kitten hints --type=line --program=@
      map ctrl+a>h>c kitten hints --type=word --program=@
      map ctrl+a>h>a kitten hints --type=url --program=@
    '';

    # font = {
    #   name = "JetBrainsMono Nerd Font";
    #   size = 12;
    # };

    shellIntegration.mode = "enabled";
    settings = {
      # shell = "/usr/bin/env sh -c \"tmux new-session -s kitty_$(date +%s)\"";
      # shell = "tmux new-session -As kitty \; new-window";

      # background_opacity = "1.0";
      window_padding_width = 2;
      scrollback_lines = 10000;
      mouse_hide_wait = 60;

      # confirm_os_window_close = 0;
      close_on_child_death = true;
      allow_remote_control = "socket-only";
      listen_on = if pkgs.stdenv.isLinux then "unix:@kitty" else "unix:/tmp/kitty";

      enabled_layouts = "tall,stack, fat, grid, splits, horizontal, vertical";
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
      "kitty_mod+;" = "previous_tab";
      "kitty_mod+'" = "next_tab";
      "kitty_mod+\\" = "goto_tab -1";
      "kitty_mod+f" = "toggle_layout stack";
      "kitty_mod+n" = "new_window_with_cwd";
      # "kitty_mod+m" = "toggle_layout tall";

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
