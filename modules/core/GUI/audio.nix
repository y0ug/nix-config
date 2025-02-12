{ ... }:
{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

  };
  # services.pipewire.wireplumber.extraConfig."10-bluez" = {
  #   "monitor.bluez.properties" = {
  #     "bluez5.enable-sbc-xq" = true;
  #     "bluez5.enable-msbc" = true;
  #     "bluez5.enable-hw-volume" = true;
  #     "bluez5.roles" = [
  #       "hsp_hs"
  #       "hsp_ag"
  #       "hfp_hf"
  #       "hfp_ag"
  #     ];
  #   };
  # };
  #
  # services.pipewire.wireplumber.extraConfig."11-bluetooth-policy" = {
  #   "wireplumber.settings" = {
  #     "bluetooth.autoswitch-to-headset-profile" = false;
  #   };
  # };
  #
  # The mSBC codec provides slightly better sound quality in calls than regular HFP/HSP, while the SBC-XQ provides better sound quality for audio listening. For more information see this link.
  # https://www.guyrutenberg.com/2021/03/11/replacing-pulseaudio-with-pipewire/
  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.autoswitch-profile" = true;
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [
        "a2dp_sink"
        "a2dp_source"
        "bap_sink"
        "bap_source"
        "hsp_hs"
        "hsp_ag"
        "hfp_hf"
        "hfp_ag"
      ];
    };
  };
}
