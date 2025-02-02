{ pkgs, config, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
      sn-pro
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      font-awesome
    ];
    # Noto Color Emoji doesn't render on Firefox
    # fontconfig.useEmbeddedBitmaps = true;
  };
}
