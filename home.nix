{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.nixos/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in 

{
  home.username = "connor";
  home.homeDirectory = "/home/connor";
  programs.git.enable = true;
  home.stateVersion = "25.05";

  xdg.configFile.nvim = {
      source = create_symlink "/home/connor/.nixos/config/nvim/";
      recursive = true;
    };

  home.packages = with pkgs; [
    nixpkgs-fmt
    nodejs
    gcc
    nodejs
    python3
    luarocks
    tree-sitter
    python3Packages.pip
  ];
}
