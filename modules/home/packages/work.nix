{ pkgs, inputs, ... }:
{

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

  ]);
  # programs.vesktop = {
  #   enable = true;
  # };
}
