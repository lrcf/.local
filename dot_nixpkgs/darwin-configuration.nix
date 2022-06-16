{ config, pkgs, ... }:

{
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  time.timeZone = "Europe/Brussels";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.fish
      pkgs.git
      pkgs.vim
    ];

  # Configure default editor and language variable for shell apps.
  environment.variables = {
    EDITOR = "vim";
    LANG = "en_GB.UTF-8";
  };

  # Load nix-darwin environment in bash, fish, and zsh.
  programs.bash.enable = true;
  programs.fish.enable = true; # Must be post-installed
  programs.zsh.enable = true; # Default in Catalina+

  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    universalaccess = {
      reduceTransparency = false;
    };

    NSGlobalDomain = {
      AppleShowScrollBars = "Always";

      # System keyboard settings
      KeyRepeat = 2;
      InitialKeyRepeat = 15;

      # System locale settings
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;

      # Expand print panel by default
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;

      # Expand save panel by default
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;

      # Save to iCloud by default
      NSDocumentSaveNewDocumentsToCloud = true;

      # Show control characters in caret notation
      NSTextShowsControlCharacters = true;

      # NSQuitAlwaysKeepsWindows

      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };

  system.activationScripts.postActivation.text =
    ''
    # PR pending for a year: LnL7/nix-darwin#230 defaults write -g AppleHighlightColor 0.968627 0.831373 1.000000 Purple

    # System locale settings
    defaults write -g AppleLanguages -array "en-GB" "cs-CZ" "sk-SK"
    defaults write -g AppleLocale -string "en_CZ"

    # Disable resume after restart by default
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

    # Enable Help Viewer Dev Mode and set their windows to not float
    defaults write com.apple.helpviewer DevMode -bool true

    # Save screen captures in .png if they’re saved as files.
    defaults write com.apple.screencapture type -string "png"
    '';
}
