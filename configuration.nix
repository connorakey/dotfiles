{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

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
    desktopManager.gnome.enable = true;
  };
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs { src = ./config/dwm; };
  };

  services.displayManager.ly.enable = true;
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.gnome.excludePackages = (with pkgs; [
    atomix
    cheese
    epiphany
    evince
    geary
    gedit
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    hitori
    iagno
    tali
    totem
  ]);

  users.users.connor = {
    isNormalUser = true;
    description = "Connor";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
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
    adwaita-icon-theme
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnome-tweaks
  ];

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        firefox
      '';
      mode = "0775";
    };
  };

  nixpkgs.config.permittedInsecurePackages = [ "qtwebengine-5.15.19" ];

  programs.zsh.enable = true;
  programs.steam.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
