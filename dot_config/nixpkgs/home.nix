{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  #
  # `stateVersion` determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  programs.home-manager.enable = true;
  home.stateVersion = "22.05";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lrcf";
  home.homeDirectory = "/Users/lrcf";

  # User installed packages
  home.packages = [
    pkgs.chezmoi
    pkgs.gnupg1
    pkgs.nodejs-18_x
    pkgs.php
  ];

  # Set environment variables
  home.sessionVariables = {
    EDITOR = "vim";
    LANG = "en_GB.UTF-8";
  };
}
