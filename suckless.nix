{ pkgs,  ...}:

{
  home.packages = with pkgs; [
    (pkgs.dmenu.overrideAttrs (_: {
      src = ./config/dmenu;
      patches = [ ];
    }))
  ];
}
