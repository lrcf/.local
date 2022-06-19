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
  home.packages = with pkgs; [
    chezmoi
    fzf
    gnupg1
    jq
    nodejs-18_x
    php
  ];

  # Set environment variables
  home.sessionVariables = {
    EDITOR = "vim";
    LANG = "en_GB.UTF-8";
  };

  # SSH setup
  programs.ssh = {
    enable = true;
    extraConfig =
      ''
      IdentityAgent ~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
      '';
  };

  # Vim setup
  programs.vim = {
    enable = true;
    extraConfig =
      ''
      " Configure FZF and remap to <C-p>
      let g:fzf_layout = { 'down': '40%' }
      nnoremap <silent> <C-p> :FZF<CR>
      '';
    plugins = with pkgs.vimPlugins; [
      fzf-vim
    ];
  };
}
