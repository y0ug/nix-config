{
  pkgs,
  inputs,
  ...
}:
{
  # package = pkgs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  home.packages = with pkgs; ([
    mattermost-desktop
    cifs-utils
    nautilus
    vesktop
    eog
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
    gimp-with-plugins
    inkscape
    weechat
    ungoogled-chromium
    mutt
    aerc # mutt alternative
    aba # aerc contact
    satty # screenshot annotation
    pinta
    (flameshot.override { enableWlrSupport = true; })
    tesseract
    lynx

    aichat
    argc

    aider-chat
    tor-browser
    session-desktop
    monero-gui
    cryptsetup

    git-filter-repo
    devenv
    inputs.glovebox.packages.${pkgs.stdenv.hostPlatform.system}.default
    #inputs.glovebox
  ]);
  # programs.vesktop = {
  #   enable = true;
  # };
}
