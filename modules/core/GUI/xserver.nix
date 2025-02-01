{ username, ... }: {
  services.xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
  };

  console.keyMap = "us";
}
