{ inputs, ... }:
{
  programs.git = {
    enable = true;

    # userName = "";
    # userEmail = "";

    # extraConfig = {
    #   init.defaultBranch = "main";
    #   # credential.helper = "store";
    #   core.editor = "nvim";
    # };
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "GitHub";
      };
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
