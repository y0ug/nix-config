{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nixpkgs.overlays = [
    # (import ../overlays/aider.nix)
    inputs.ida-pro-overlay.overlays.default
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # "vmware-workstation"
    ];

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

    krita # image editor, kde :(
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
    inputs.glovebox.packages.${pkgs.stdenv.hostPlatform.system}.default
    #inputs.glovebox
    openai-whisper
    openai-whisper-cpp
    whisper-ctranslate2
    python312Packages.faster-whisper

    # for voice_typing script should create a package
    #  https://github.com/themanyone/voice_typing
    ydotool
    lame
    (sox.override { enableLame = true; })

    # qalculate
    qalculate-gtk
    programmer-calculator # pcalc
    gnome-calculator

    # vmware-workstation
    mosh

    # raw image editor
    # garktable
    # digikam
    # rawtherapee

    valent
    localsend
    # kdePackages.kdeconnect-kde

    # claude-code
    meld # git diff tool GUI

    # for binary ninja
    libglvnd # For libEGL
    act # local github actions
    mitmproxy
    # (callPackage ida-pro {
    #   # Alternatively, fetch the installer through `fetchurl`, use a local path, etc.
    #   # runfile = /nix/store/z83flk6c9fm9li3gs13vbamq2szg9rwf-ida-pro_90_x64linux.run;
    #   runfile = /nix/store/s9gq70w56355yrg33054g97zscr3r64i-ida-pro_91_x64linux.gghkjkrun;
    # })

    inputs.elephant.packages.${pkgs.stdenv.hostPlatform.system}.default
    eigenwallet
  ]);

  # programs.vesktop = {
  #   enable = true;
  # };
}
