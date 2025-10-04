{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "desktop";

  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Melbourne";
  
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs {
      src = ./config/dwm;
    };
  };

  services.displayManager.ly.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.connor = {
    isNormalUser = true;
    description = "Connor";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  hardware.bluetooth.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim 
    wget
    git
    ripgrep
    fd
    fzf
    _1password-gui
    tmux
    zoxide
    flatpak
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        firefox
      '';
      mode = "0775";
    };
  };

  programs.zsh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
