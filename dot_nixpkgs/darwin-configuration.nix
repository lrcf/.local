{ config, pkgs, ... }:

{
  # Used for backwards compatibility.
  system.stateVersion = 4;
  time.timeZone = "Europe/Brussels";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Packages installed for the whole system
  environment.systemPackages = with pkgs; [
    fish
    git
    vim
  ];
  system.activationScripts.applications.text =
    ''
    # Adds `fish` to the list of trusted shells
    # `command` is a POSIX compatible built-in.
    # -> See: https://stackoverflow.com/a/37056347

    # TODO: Fix path issue
    # TODO: Find a dynamic path
    if command -v fish; then
      _bin_path="/run/current-system/sw/bin/fish"
      grep -qxF $_bin_path /etc/shells || echo $_bin_path | sudo tee -a /etc/shells > /dev/null
    fi
    '';

  # Packages not available on Nix installed for the whole system
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    casks = [
      "1password"
      "bettertouchtool"
      "dash"
      "raycast"
      "secretive"
    ];
  };

  # Set default login shell
  # environment.loginShell = "/run/current-system/sw/bin/fish";

  # Load nix-darwin environment in bash, fish, and zsh.
  programs.bash.enable = true;
  programs.fish.enable = true; # Must be post-installed
  programs.zsh.enable = true; # Default in Catalina+

  # System configuration
  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      ShowPathbar = true;
      ShowStatusBar = true;
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

      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };

  # Additional configuration not supported by the system
  system.activationScripts.extraUserActivation.text =
    ''
    # Changes highlight colours
    defaults write -g AppleHighlightColor -string "0.968627 0.831373 1.000000 Purple"

    # System locale settings
    defaults write -g AppleLanguages -array "en-GB" "cs-CZ" "sk-SK"
    defaults write -g AppleLocale -string "en_CZ"

    # Disable resume after restart by default
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

    defaults write com.apple.screencapture type -string "png"

    # Terminal settings
    defaults write com.apple.Terminal SecureKeyboardEntry -bool true
    defaults write com.apple.Terminal "Startup Window Settings" -string "Basic"
    '';
}
