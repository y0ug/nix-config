{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

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
