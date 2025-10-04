{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.dmenu.overrideAttrs (oldAttrs: {
      src = pkgs.lib.cleanSource ../config/dmenu;
      patches = [];
    }))
    slock
  ];
}

