{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; ([
    nodejs
    gcc
    nixfmt-rfc-style

    direnv

    zsh
    nushell
    atuin # shell history
    tmux

    man-pages # extra man pages
    killall

    fastfetch

    # vim

    yazi # terminal file manager
    superfile # SPF file manager to be test
    lf # go terminal file manager
    ncdu # disk space
    dust # disk usage analyzer

    # archives
    zip
    xz
    unzip
    p7zip
    zstd

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses
    curl
    wget
    lynx
    xh # curl replacement for API

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    # eza # A modern replacement for ‘ls’ , homemagner
    # fzf # A command-line fuzzy finder, homemanager
    bat # cat alternative
    fd # find replacement
    tdf # cli pdf viewer
    moar # alterative pager
    sd # better sed

    # Session manager used with zoxide and tmux
    sesh

    delta # git diff tool
    difftastic

    glow # markdown previewer in terminal
    presenterm # markdown presentation tool

    # encryption
    sops
    age

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    gnupg
    bc # calculator

    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    btop # replacement of htop/nmon
    iftop # network monitoring
    htop

    # system call monitoring
    lsof # list open files

    # github cli
    gh

    hexyl # hexviewr
    xxd # hexviewer
    lazygit
    starship
    lazydocker

    chezmoi

    # work
    pandoc
    flare-floss

    # dev/python general
    (python3.withPackages (
      ps: with ps; [
        markitdown
        pipx
      ]
    ))
    cargo

    # fzf-preview.sh dependencies
    imgcat
    chafa
    file
    tlrc # better man tldr

  ]);

  programs.go = {
    enable = true;
    goPath = ".go";
  };

  programs.fzf = {
    enable = true;
    # enableZshIntegration = true;
    defaultOptions = [
      # "--preview bat --color=always --style=header,grid --line-range :500 {}"
      "--preview 'fzf-preview.sh {}'"
    ];
  };

  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
  programs.htop.enable = true;
  # programs.tmux.enable = true;
  programs.starship.enable = true;
  programs.bash.enable = true;
  # program.lazygit.enable = true;

  home.sessionPath = [ "$GOPATH/bin" ];

  home.file.fzf = {
    enable = true;
    target = ".local/bin/fzf-preview.sh";
    executable = true;
    text = ''
      #!/usr/bin/env bash
      #
      # The purpose of this script is to demonstrate how to preview a file or an
      # image in the preview window of fzf.
      #
      # Dependencies:
      # - https://github.com/sharkdp/bat
      # - https://github.com/hpjansson/chafa
      # - https://iterm2.com/utilities/imgcat

      if [[ $# -ne 1 ]]; then
        >&2 echo "usage: $0 FILENAME"
        exit 1
      fi

      file=''${1/#\~\//$HOME/}
      type=$(file --dereference --mime -- "$file")

      if [[ ! $type =~ image/ ]]; then
        if [[ $type =~ =binary ]]; then
          file "$1"
          exit
        fi

        # Sometimes bat is installed as batcat.
        if command -v batcat > /dev/null; then
          batname="batcat"
        elif command -v bat > /dev/null; then
          batname="bat"
        else
          cat "$1"
          exit
        fi

        ''${batname} --color=always -- "$file"
        exit
      fi

      dim=''${FZF_PREVIEW_COLUMNS}x''${FZF_PREVIEW_LINES}
      if [[ $dim = x ]]; then
        dim=$(stty size < /dev/tty | awk '{print $2 "x" $1}')
      elif ! [[ $KITTY_WINDOW_ID ]] && (( FZF_PREVIEW_TOP + FZF_PREVIEW_LINES == $(stty size < /dev/tty | awk '{print $1}') )); then
        # Avoid scrolling issue when the Sixel image touches the bottom of the screen
        # * https://github.com/junegunn/fzf/issues/2544
        dim=''${FZF_PREVIEW_COLUMNS}x$((FZF_PREVIEW_LINES - 1))
      fi

      # 1. Use kitty icat on kitty terminal
      if [[ $KITTY_WINDOW_ID ]]; then
        # 1. 'memory' is the fastest option but if you want the image to be scrollable,
        #    you have to use 'stream'.
        #
        # 2. The last line of the output is the ANSI reset code without newline.
        #    This confuses fzf and makes it render scroll offset indicator.
        #    So we remove the last line and append the reset code to its previous line.
        kitty icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place="$dim@0x0" "$file" | sed '$d' | sed $'$s/$/\e[m/'

      # 2. Use chafa with Sixel output
      elif command -v chafa > /dev/null; then
        chafa -s "$dim" "$file"
        # Add a new line character so that fzf can display multiple images in the preview window
        echo

      # 3. If chafa is not found but imgcat is available, use it on iTerm2
      elif command -v imgcat > /dev/null; then
        # NOTE: We should use https://iterm2.com/utilities/it2check to check if the
        # user is running iTerm2. But for the sake of simplicity, we just assume
        # that's the case here.
        imgcat -W "''${dim%%x*}" -H "''${dim##*x}" "$file"

      # 4. Cannot find any suitable method to preview the image
      else
        file "$file"
      fi
    '';
  };

  # programs.zsh = {
  #   enable = true;
  # };
  # programs.neovim = {
  #   enable = true;
  #
  #   defaultEditor = true;
  #
  #   viAlias = true;
  #   vimAlias = true;
  #
  #   withRuby = true;
  #   withNodeJs = true;
  #   withPython3 = true;
  #
  #   extraLuaPackages = ps: [ ps.magick ];
  #   extraPackages = [ pkgs.imagemagick ];
  #
  #   plugins = [
  #     pkgs.vimPlugins.lazy-nvim
  #   ];
  # };
}
