{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Communication
    mattermost-desktop
    vesktop
    
    # Development
    vscodium
    zed-editor
    git-filter-repo
    devenv
    inputs.glovebox.packages.${pkgs.stdenv.hostPlatform.system}.default
    
    # File management
    cifs-utils
    nautilus
    file-roller
    
    # Tools
    go-jira
    lftp
    
    # Browsers
    librewolf
    ungoogled-chromium
    tor-browser
    
    # Email
    mutt
    aerc
    aba
    
    # Media
    gimp-with-plugins
    inkscape
    pinta
    satty
    tesseract
    
    # Gaming/Remote
    moonlight-qt
    
    # Security
    keepassxc
    cryptsetup
    session-desktop
    monero-gui
    
    # AI tools
    aichat
    argc
    aider-chat
  ];
}