({ pkgs, ... }: {
  # here go the darwin preferences in config items
  services.nix-daemon.enable = true;
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility. please read the changelog
  # before changing: `darwin-rebuild changelog`.
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  # If you're on an Intel system, replace with "x86_64-darwin"
  nixpkgs.hostPlatform = "x86_64-darwin";

  # Declare the user that will be running `nix-darwin`.
  users.users.max = {
    name = "max";
    home = "/Users/max";
  };
  environment = {
    shells = [ pkgs.bash pkgs.zsh ];
    # Set the default shell to zsh.
    loginShell = "zsh";
    # Set the default editor to neovim.
    editor = "nvim";
    systemPackages = [ pkgs.coreutils pkgs.nixpkgs-fmt ];
  };
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    fonts = {
      enableFontDir = true;
      fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
    };
    defaults = {
      NSGlobalDomain = {
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
      };
    };
  };
})
