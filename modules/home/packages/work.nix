{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; ([
    mattermost-desktop
    cifs-utils
    nautilus
  ]);
}
