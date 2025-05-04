{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # System monitoring
    iotop
    sysstat
    lm_sensors
    
    # System analysis
    strace
    ltrace
    
    # Hardware tools
    ethtool
    pciutils
    usbutils
  ];
}