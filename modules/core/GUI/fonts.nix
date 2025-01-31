{ pkgs, config, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
      sn-pro
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];
  };
}
