{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; ([
    mattermost-desktop
    cifs-utils
    nautilus
    vesktop
    eog
    webex
    keepassxc
    file-roller
    go-jira
    lftp
    ffmpeg
    librewolf
    devenv
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
    monero-gui
    cryptsetup

    git-filter-repo

  ]);
  # programs.vesktop = {
  #   enable = true;
  # };
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}
