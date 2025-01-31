{...}: 
{
  imports = [
    ./packages/common.nix
    ./packages/linux.nix
    ./packages/linux_gui.nix
    ./wezterm.nix
    ./bat.nix                         # better cat command
    ./btop.nix                        # resouces monitor 
    ./fuzzel.nix                      # launcher
    ./git.nix                         # version control
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./kitty.nix                       # terminal
    ./swaync/swaync.nix               # notification deamon
    ./swaylock.nix                    # lock screen
    ./waybar                          # status bar
  ];
  #nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

}
