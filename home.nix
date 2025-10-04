{ config, pkgs, ... }:

{
  home.username = "connor";
  home.homeDirectory = "/home/connor";
  programs.git.enable = true;
  home.stateVersion = "25.05";

  home.file.".config/nvim".source = ./config/nvim;
}
