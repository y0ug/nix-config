{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Shell and terminal utilities
    zsh
    nushell
    atuin
    tmux
    starship
    direnv
    nix-zsh-completions
    zsh-nix-shell

    # Development tools
    gcc
    nodejs
    git
    gh
    lazygit
    nixfmt-rfc-style
    difftastic
    cargo
    go

    # Python ecosystem
    (python3.withPackages (ps: with ps; [
      markitdown
      pipx
    ]))

    # System monitoring
    btop
    htop
    iftop
    fastfetch
    glances

    # File management
    nnn
    bat
    fd
    ripgrep
    fzf
    yq-go
    jq
    moar
    glow
    presenterm
    hexyl
    xxd

    # Networking tools
    curl
    wget
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc
    xh

    # Compression tools
    zip
    xz
    unzip
    p7zip
    zstd

    # Security
    sops
    age
    gnupg
    pinentry-curses

    # System utilities
    file
    which
    tree
    gnused
    gnutar
    gawk
    bc
    nix-output-monitor

    # Configuration management
    chezmoi
  ];
}