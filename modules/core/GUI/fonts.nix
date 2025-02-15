{ pkgs, config, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.symbols-only
      font-awesome
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      jetbrains-mono
      fira-code
    ];
    # fontconfig = {
    #   defaultFonts = {
    #     serif = [
    #       # "Noto Serif"
    #       "Noto Color Emoji"
    #     ];
    #     sansSerif = [
    #       # "Noto Sans"
    #       "Noto Color Emoji"
    #     ];
    #     monospace = [
    #       "JetBrainsMono Nerd Font"
    #       "Noto Color Emoji"
    #     ];
    #     emoji = [ "Noto Color Emoji" ];
    #   };
    #   antialias = true;
    #   hinting = {
    #     style = "medium";
    #   };
    #   subpixel = {
    #     rgba = "rgb";
    #     lcdfilter = "default";
    #   };
    #
    # };
    # Noto Color Emoji doesn't render on Firefox
    # fontconfig.useEmbeddedBitmaps = true;
  };
}
