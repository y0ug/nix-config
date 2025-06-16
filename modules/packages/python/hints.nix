{
  pkgs,
  lib,

  git,
  ydotool,
  gobject-introspection,
  gcc,
  cairo,
  pkg-config,
  python3,
  gtk3,
  python3Packages,
  python312Packages,
  intltool,
  wrapGAppsHook3,

  gtk-layer-shell,
  grim,
}:

python3Packages.buildPythonPackage {
  pname = "hints";
  version = "git";

  src = pkgs.fetchFromGitHub {
    owner = "AlfredoSequeida";
    repo = "hints";
    rev = "8ae81d866a991a7751b3818014a0cad015b6a440";
    hash = "sha256-c46EmdIVyAYmDhRgVc8Roump/DwHynKpj2/7mzxaNiY=";
  };

  #makeWrapperArgs = ["--set" "HINTS_EXPECTED_BIN_DIR" "$out/bin"];

  nativeBuildInputs = [
    gobject-introspection
    intltool
    pkg-config
    wrapGAppsHook3
    python3Packages.setuptools
  ];

  buildInputs =
    [
      # pkgs.makeWrapper
      # pkgs.libsForQt5.kwin
      git
      ydotool
      gcc
      cairo
      python3
      gtk3
      python3Packages.pillow
      python312Packages.pygobject3
      python312Packages.opencv4
      python312Packages.evdev
    ]
    ++ (
      if pkgs.stdenv.isLinux && builtins.getEnv "XDG_SESSION_TYPE" == "wayland" then
        [
          gtk-layer-shell
          grim
        ]
      else
        [ ]
    );

  pythonPath = with python3Packages; [
    dbus-python
    distutils-extra
    pyatspi
    pycairo
    pygobject3
    systemd
    opencv4
    pyscreenshot
    evdev
  ];

  env = {
    HINTS_EXPECTED_BIN_DIR = "$out/bin";
    HOME = "$out/home/";
  };

  # for some reason hintsd refuses to be created so i just make it myslef
  # postInstall = ''
  #     # mv -v $out/bin/hints $out/bin/hintsd
  #     cat $out/bin/hints | sed "s/hints.hints/hints.mouse_service/g" > $out/bin/hintsd
  #     chmod +x $out/bin/hintsd
  # '';

  meta = {
    description = "Hints lets you navigate GUI applications in Linux without your mouse by displaying \"hints\" you can type on your keyboard to interact with GUI elements.";
    homepage = "https://github.com/AlfredoSequeida/hints";
    license = lib.licenses.gpl3;
    maintainers = [
      lib.maintainers.DEATHB4DEFEAT
    ];
    platforms = lib.platforms.linux;
  };
}
