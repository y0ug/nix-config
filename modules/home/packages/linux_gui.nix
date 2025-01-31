{ pkgs, inputs, ...}:
{
  home.packages = with pkgs; ([
  firefox
  evince # pdf viewier
  imv # image viewer
  gparted # partition editor
  # obsidian # markdown editor
   man-pages					            	  # extra man pages
   killall  
   libnotify
   bleachbit # disk cleaner
  dust # disk usage analyzer 
  yazi                              # terminal file manager
  zenity                            # GUI for yazi
  libnotify
  ncdu # disk space
  pamixer
  pavucontrol
  playerctl
  wl-clipboard
  cliphist
  xdg-utils
]);
}
