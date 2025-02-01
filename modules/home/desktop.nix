{ ... }: {
  imports = [
    ./packages/common.nix
    ./packages/linux.nix
    ./packages/linux_gui.nix
    ./wezterm.nix # terminal
    ./kitty.nix # terminal
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./git.nix # version control

    ./hyprland.nix
    ./fuzzel.nix
    ./waybar
  ];
  #nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
