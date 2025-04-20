{ ... }:
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
}
