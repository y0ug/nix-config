{ config, pkgs, ... }: {
  imports =
    [ ../modules/home/packages/common.nix ../modules/home/packages/linux.nix ];

  home.username = "rick";
  home.homeDirectory = "/home/rick";

  home.packages = with pkgs; [
    iotop # io monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

}
