{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "trezor-suite"
    ];
  imports = [ inputs.walker.homeManagerModules.default ];

  # programs.walker.enable = true;
  # package = pkgs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  home.packages = with pkgs; ([
    mattermost-desktop
    cifs-utils
    nautilus
    vesktop
    eog
    browserpass

    trash-cli # trash-put instead of rm

    # webex # unfree
    keepassxc
    file-roller
    go-jira
    lftp
    ffmpeg-full
    librewolf
    moonlight-qt
    vscodium
    zed-editor
    weechat
    chromium
    # ungoogled-chromium
    mutt
    aerc # mutt alternative
    aba # aerc contact
    satty # screenshot annotation
    swappy # screenshot annotation

    # krita # image editor, kde :(
    # gimp-with-plugins
    inkscape
    pinta
    qview
    zathura

    zk # not taking

    peazip
    # transmission_4
    transmission_4-gtk

    # don't really work on wayland
    # (flameshot.override { enableWlrSupport = true; })

    tesseract # ocr
    ocrmypdf

    aichat
    argc

    aider-chat
    tor-browser
    session-desktop
    monero-gui
    electrum
    cryptsetup

    git-filter-repo
    devenv
    # inputs.glovebox.packages.${pkgs.stdenv.hostPlatform.system}.default
    #inputs.glovebox
    openai-whisper
    whisper-cpp
    whisper-ctranslate2
    python312Packages.faster-whisper

    # for voice_typing script should create a package
    #  https://github.com/themanyone/voice_typing
    ydotool
    lame
    (sox.override { enableLame = true; })

    # qalculate
    qalculate-gtk
    # programmer-calculator # pcalc
    pcalc
    gnome-calculator

    # vmware-workstation
    mosh
    tailscale

    trezorctl
    trezor-suite
    trezor-udev-rules

    # raw image ediitor
    # garktable
    # digikam
    # rawtherapee

    # inputs.elephant.packages.${pkgs.stdenv.hostPlatform.system}.default

    # valent
    localsend
    # kdePackages.kdeconnect-kde

    # claude-code
    meld # git diff tool GUI

    act # local github actions
    mitmproxy

    eigenwallet
    wl-kbptr
    wlrctl
  ]);

  # programs.vesktop = {
  #   enable = true;
  # };
}
