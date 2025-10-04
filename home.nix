{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.nixos/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
  };
in 

{
  home.username = "connor";
  home.homeDirectory = "/home/connor";
  programs.git.enable = true;
  home.stateVersion = "25.05";

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
    })
      configs;

  home.packages = with pkgs; [
    nixpkgs-fmt
    nodejs
    gcc
    nodejs
    python3
    luarocks
    tree-sitter
    python3Packages.pip
    fastfetch
  ];
}
