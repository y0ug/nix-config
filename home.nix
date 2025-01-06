{ config, pkgs, user, ... }:
let
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
  {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # home.username = user.name;
  # home.homeDirectory = user.homeDir;
  home.username = "rick"; 
  home.homeDirectory = 
    if isLinux then "/home/rick" else
    if isDarwin then "/Users/rick" else unsupported;

  programs.direnv.enable = true;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; ([
    neovim 
    nodejs
    gcc

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
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
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
    btop  # replacement of htop/nmon
    iftop # network monitoring

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
  ] ++ lib.optionals isLinux [
      iotop # io monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      # system tools
      sysstat
      lm_sensors # for `sensors` command
      ethtool
      pciutils # lspci
      usbutils # lsusb   


      bitwarden-cli # failed to build on darwin
    ] ++ lib.optionals isDarwin [
      # macOS packages
    ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  programs.git = {
    enable = true;
    userName = "Hugo Caron" ;
    userEmail = "hca4443@gmail.com" ;
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rick/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
