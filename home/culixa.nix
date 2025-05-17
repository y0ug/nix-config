{ config, pkgs, ... }:
let
  codium = [ "codium.desktop" ];
  codiumURL = [ "codium-url-handler.desktop" ] ++ codium;
  fileroller = [ "org.gnome.FileRoller.desktop" ];
  evince = [ "org.gnome.Evince.desktop" ];
  nautilus = [ "org.gnome.Nautilus.desktop" ];
  eog = [ "org.gnome.eog.desktop" ];
  yazi = [ "yazi.desktop" ];
  nvim = [ "nvim.desktop" ];
  imv = [ "imv.desktop" ];
  mpv = [ "mpv.desktop" ];
  qview = [ "com.interversehq.qView.desktop" ];

  peazip = [ "peazip-open.desktop" ];
  ink = [ "org.inkscape.Inkscape.desktop" ];
  gimp = [ "gimp.desktop" ];
  signal = [ "signal-desktop.desktop" ];
  telegram = [ "org.telegram.desktop.desktop" ];
  librewolf = [ "librewolf.desktop" ];
  firefox = [ "firefox.desktop" ];
  chromium = [ "desktop-chromium.desktop" ];
  zathura = [ "org.pwmt.zathura.desktop" ];
  discord = [ "vesktop.desktop" ];

  browser = librewolf ++ firefox ++ chromium;
  editor = nvim ++ codium ++ yazi;
  image = qview ++ imv ++ eog ++ gimp ++ ink;
  video = mpv ++ qview;
  document = zathura ++ evince;
  files = yazi ++ nautilus;
  bittorent = [ "transmission-gtk.desktop" ];

  xdgAssociations =
    type: program: list:
    builtins.listToAttrs (
      map (e: {
        name = "${type}/${e}";
        value = program;
      }) list
    );

  # audio = xdgAssociations "audio" audioPlayer ["mp3" "flac" "wav" "aac"];

  browserTypes =
    (xdgAssociations "application" browser [
      "x-extension-htm"
      "x-extension-html"
      "x-extension-shtml"
      "x-extension-xht"
      "x-extension-xhtml"
      "x-extension-xhtml+xml"
    ])
    // (xdgAssociations "x-scheme-handler" browser [
      "about"
      "ftp"
      "http"
      "https"
      "unknown"
      "webcal"
      "webcals"
      "mailto"
    ])
    // (xdgAssociations "text" browser [
      "html"
      "calendar"
      "x-web-markup"
    ]);

  documentTypes = xdgAssociations "application" document [
    "epub+zip"
    "pdf"
  ];

  imageTypes = xdgAssociations "image" image [
    "png"
    "svg"
    "svg+xml"
    "jpeg"
    "bmp"
    "gif"
    "avif"
    "x-eps"
    "x-icns"
    "x-ico"
    "tiff"
    "x-psd"
    "x-webp"
    "webp"
    "x-xcf"
  ];

  videoTypes = xdgAssociations "video" video [
    "mp4"
    "mpeg"
    "mxf"
    "ogg"
    "sdp"
    "smil"
    "streamingmedia"
    "vnd.apple.mpegurl"
    "vnd.ms-asf"
    "vnd.rn-realmedia"
    "vnd.rn-realmedia-vbr"
    "x-cue"
    "x-extension-m4a"
    "x-extension-mp4"
    "x-flv"
    "x-matroska"
    "x-mpegurl"
    "x-ms-wmv"
    "x-msvideo"
    "x-ogg"
    "x-ogm"
    "x-shorten"
    "x-smil"
    "x-streamingmedia"
  ];

  archiveTypes = xdgAssociations "application" peazip [
    "bzip2"
    "gzip"
    "vnd.rar"
    "x-7z-compressed"
    "x-7z-compressed-tar"
    "x-bzip"
    "x-bzip-compressed-tar"
    "x-compress"
    "x-compressed-tar"
    "x-cpio"
    "x-gzip"
    "x-gzip-compressed-tar"
    "x-lha"
    "x-lzip"
    "x-lzip-compressed-tar"
    "x-lzma"
    "x-lzma-compressed-tar"
    "x-rar-compressed"
    "x-tar"
    "x-tarz"
    "x-xar"
    "x-xz"
    "x-xz-compressed-tar"
    "x-zstd-compressed-tar"
    "zip"
    "zstd"
  ];

  editorTypes = xdgAssociations "text" editor [
    "plain"
    # "x-markdown"
    "x-shellscript"
    "x-c++src"
    "x-csrc"
    "x-c++hdr"
  ];

  bittorentTypes =
    (xdgAssociations "application" bittorent [
      "x-bittorrent"
      "x-bittorrent-file"
    ])
    // (xdgAssociations "x-scheme-handler" bittorent [
      "magnet"
    ]);

  defaultApplications =
    browserTypes
    // documentTypes
    // imageTypes
    // videoTypes
    // archiveTypes
    // editorTypes
    // bittorentTypes
    // {
      "inode/directory" = files;

      "image/heif" = imv ++ image;
      "x-scheme-handler/codium" = codiumURL;
      "x-scheme-handler/code" = codiumURL;
      "x-scheme-handler/discord" = discord;
      "x-scheme-handler/chrome" = chromium;
      "x-scheme-handler/tg" = telegram;
      "x-scheme-handler/sgnl" = signal;
      "x-scheme-handler/signalcaptcha" = signal;
    };

  user = "rick";
in
{
  imports = [
    ../modules/home/desktop.nix
    ../modules/home/packages/work.nix
  ];

  home.username = "rick";
  home.homeDirectory = "/home/rick";
  home.stateVersion = "24.05";

  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = defaultApplications;
  xdg.userDirs.enable = true;
  # Not seeing my library
  # services = {
  #   mpd = {
  #     enable = true;
  #     network.startWhenNeeded = true;
  #     musicDirectory = "~/Music";
  #     extraConfig = ''
  #       log_level "verbose"
  #       audio_output {
  #         type "pipewire"
  #         name "Pipewire Output"
  #       }
  #     '';
  #   };
  #   mpd-mpris.enable = false;
  # };
  #
  # home.packages = with pkgs; ([
  #   ncmpcpp
  # ]);
}
