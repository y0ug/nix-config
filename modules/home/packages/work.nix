{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (_: prev: {
      aider-chat = (prev.aider-chat.override { }).overridePythonAttrs (oldAttrs: {
        dependencies = oldAttrs.dependencies ++ [
          prev.python3Packages.google-api-core
          prev.python3Packages.google-auth
          prev.python3Packages.google-cloud-core
          prev.python3Packages.googleapis-common-protos
          prev.python3Packages.google-generativeai
        ];
      });
    })
    # (_: prev: {
    #   aider-chat = prev.aider-chat.overridePythonAttrs (oldAttrs: {
    #     dependencies = oldAttrs.dependencies ++ [
    #       (prev.python3Packages.litellm.overridePythonAttrs
    #         (litellmAttrs: {
    #           dependencies = litellmAttrs.dependencies ++ [
    #             prev.python3Packages.google-generativeai
    #             prev.python3Packages.google-api-core
    #             prev.python3Packages.google-auth
    #             prev.python3Packages.google-cloud-core
    #             prev.python3Packages.googleapis-common-protos
    #           ];
    #         })
    #
    #         prev.python3Packages.google-generativeai
    #         prev.python3Packages.google-api-core
    #         prev.python3Packages.google-auth
    #         prev.python3Packages.google-cloud-core
    #         prev.python3Packages.googleapis-common-protos
    #       )
    #     ];
    #   });
    # })
  ];

  home.packages = with pkgs; ([
    mattermost-desktop
    cifs-utils
    nautilus
    vesktop
    eog
    # webex # unfree
    keepassxc
    file-roller
    go-jira
    lftp
    ffmpeg-full
    librewolf
    devenv
    moonlight-qt
    vscodium
    zed-editor
    gimp-with-plugins
    inkscape
    weechat
    ungoogled-chromium
    mutt
    aerc # mutt alternative
    aba # aerc contact
    satty # screenshot annotation
    pinta
    (flameshot.override { enableWlrSupport = true; })
    tesseract
    lynx

    aichat
    argc

    aider-chat

  ]);
  # programs.vesktop = {
  #   enable = true;
  # };
}
