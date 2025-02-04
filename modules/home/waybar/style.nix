{ lib, ... }:
{
  programs.waybar.style = lib.readFile ./tokyonight.css + "\n" + lib.readFile ./style.css;
}
