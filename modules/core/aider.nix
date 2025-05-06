{ ... }:
{
  nixpkgs.overlays = [
    (_: prev: {
      aider-chat = (prev.aider-chat.override { }).overridePythonAttrs (oldAttrs: {
        src = prev.fetchFromGitHub {
          owner = "Aider-AI";
          repo = "aider";
          tag = "v0.9";
          deepClone = true;
          hash = "sha256:0000000000000000000000000000000000000000000000000000";
          # hash = "sha256:0000000000000000000000000000000000000000000000000000";
        };
        dependencies = oldAttrs.dependencies ++ [
          prev.python3Packages.google-api-core
          prev.python3Packages.google-auth
          prev.python3Packages.google-cloud-core
          prev.python3Packages.googleapis-common-protos
          prev.python3Packages.google-generativeai
        ];
      });
    })
  ];
}
