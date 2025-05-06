final: prev: {
  aider-chat = (prev.aider-chat.override { }).overridePythonAttrs (oldAttrs: {
    version = "v0.82.3.dev";
    src = prev.fetchFromGitHub {
      owner = "Aider-AI";
      repo = "aider";
      tag = "v0.82.3.dev";
      deepClone = true;
      hash = "sha256-bBzNSXksEJDi7J1NnJ9y89psRHfmKjX+TtJO3RAzu5A=";
      # hash = "sha256:0000000000000000000000000000000000000000000000000000";
    };
    # postPatch = "";
    # disabledTestPaths = [ ];
    dependencies = oldAttrs.dependencies ++ [
      prev.python3Packages.google-api-core
      prev.python3Packages.google-auth
      prev.python3Packages.google-cloud-core
      prev.python3Packages.googleapis-common-protos
      prev.python3Packages.google-generativeai
    ];
  });
}
