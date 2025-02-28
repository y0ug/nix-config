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
  ]);
  # programs.vesktop = {
  #   enable = true;
  # };
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}
