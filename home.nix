{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.nixos/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    alacritty = "alacritty";
    ohmyposh = "ohmyposh";
  };

in {

  home.username = "connor";
  home.homeDirectory = "/home/connor";
  programs.git.enable = true;
  home.stateVersion = "25.05";

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mochatto";
    EDITOR = "nvim";
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

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
    alacritty
    firefox
    dmenu
    catppuccin-gtk
    oh-my-posh
    vesktop
    steam
    spotify
    rustup
    unzip
    go
    jetbrains.webstorm
    jetbrains.rust-rover
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.clion
    jetbrains.gateway
  ];
}
