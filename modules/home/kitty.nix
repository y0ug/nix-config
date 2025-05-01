{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    # themeFile = "gruvbox-dark";

    # include ${../../themes/tokyonight/kitty/tokyonight_night.conf}
    extraConfig = ''
      symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono

      # tmux settings
      map ctrl+w>r load_config_file
      # Make ctrl+w ctrl+a to send ctrl+a
      map ctrl+w>ctrl+a send_text all \x01
      map ctrl+shift+2 send_text all \x00

      ### Layout operations ###
      # stack layout behaves the same as tmux pane zoom
      enabled_layouts splits,stack
      map ctrl+w>z toggle_layout stack
      map ctrl+w>space layout_action rotate

      ### Tab operations, corresponds to tmux window ###
      map ctrl+w>c new_tab
      map ctrl+w>& close_tab
      map ctrl+w>s new_tab_with_cwd

      map ctrl+w>w select_tab
      map ctrl+w>n next_tab
      map ctrl+w>p previous_tab
      map ctrl+w>0 goto_tab 1
      map ctrl+w>1 goto_tab 2
      map ctrl+w>2 goto_tab 3
      map ctrl+w>3 goto_tab 4
      map ctrl+w>4 goto_tab 5
      map ctrl+w>5 goto_tab 6
      map ctrl+w>6 goto_tab 7
      map ctrl+w>7 goto_tab 8
      map ctrl+w>8 goto_tab 9
      map ctrl+w>9 goto_tab 10

      # tmux sensible keybinding
      map ctrl+w>ctrl+p previous_tab
      map ctrl+w>ctrl+n next_tab

      ### Window operations, corresponds to tmux pane ###
      map ctrl+w>" launch --location=hsplit --cwd=current
      map ctrl+w>% launch --location=vsplit --cwd=current

      map ctrl+w>x close_window
      map ctrl+w>f new_window_with_cwd

      map ctrl+w>q focus_visible_window
      map ctrl+w>o next_window

      map ctrl+w>up neighboring_window up
      map ctrl+w>down neighboring_window down
      map ctrl+w>left neighboring_window left
      map ctrl+w>right neighboring_window right

      map ctrl+w>k neighboring_window up
      map ctrl+w>j neighboring_window down
      map ctrl+w>h neighboring_window left
      map ctrl+w>l neighboring_window right

      ### hints kitten ###
      # Open file or url
      map ctrl+w>h>f kitten hints --type=linenum --linenum-action=tab nvim +{line} {path}
      map ctrl+w>h>u open_url_with_hints
      # Insert text directly
      map ctrl+w>h>p kitten hints --type=path --program=-
      map ctrl+w>h>w kitten hints --type=word --program=-
      map ctrl+w>h>h kitten hints --type=hash --program=-
      # Copy text to clipboard
      map ctrl+w>h>l kitten hints --type=line --program=@
      map ctrl+w>h>c kitten hints --type=word --program=@
      map ctrl+w>h>a kitten hints --type=url --program=@
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
      clipboard_control = "write-primary write-clipboard no-append";
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
      # "ctrl+w" = "paste_from_clipboard";
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
