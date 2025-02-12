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
  ]);
  # programs.vesktop = {
  #   enable = true;
  # };
}
