{ pkgs, inputs, ... }: {
  home.packages = with pkgs; ([
    neovim
    nodejs
    gcc
    nixfmt

    direnv

    zsh
    nushell
    atuin # shell history
    tmux

    fastfetch

    nnn # terminal file manager
    # archives
    zip
    xz
    unzip
    p7zip

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

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    bat # cat alternative
    fd # find replacement
    tdf # cli pdf viewer

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
    zstd
    gnupg

    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    glow # markdown previewer in terminal
    btop # replacement of htop/nmon
    iftop # network monitoring
    htop

    # system call monitoring
    lsof # list open files

    # github cli
    gh

    hexyl # hexviewr
    lazygit
    starship
    xh # curl replacement for API

    chezmoi

    # work
    pandoc
    flare-floss

    # dev/python general
    pre-commit
    poetry
    pipx
    go
  ]);

}
