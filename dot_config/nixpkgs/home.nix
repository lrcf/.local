{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "22.05";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lrcf";
  home.homeDirectory = "/Users/lrcf";

  home.packages =
    [ pkgs.chezmoi
      pkgs.gnupg1
      pkgs.nodejs-18_x
      pkgs.php
    ];
}
