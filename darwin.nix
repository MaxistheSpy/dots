({pkgs, ...}: {
  users.users.max = {
    name = "max";
    home = "/Users/max";
  };
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  environment.shells = [pkgs.bash pkgs.zsh];
  environment.loginShell = pkgs.zsh;
  environment.systemPackages = [pkgs.coreutils];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  fonts.fontDir.enable = true; # DANGER
  fonts.fonts = [(pkgs.nerdfonts.override {fonts = ["Meslo"];})];
  services.nix-daemon.enable = true;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.dock.autohide = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  # backwards compat; don't change
  system.stateVersion = 4;
})
