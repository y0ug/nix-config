{ ... }: {
  imports = [
    ./packages/common.nix
    ./packages/linux.nix
    ./packages/linux_gui.nix
    ./wezterm.nix
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./git.nix # version control
    ./kitty.nix # terminal
  ];
  #nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
