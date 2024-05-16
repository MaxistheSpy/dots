{ pkgs, ... }:
{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  # Used for backwards compatibility. please read the changelog
  # before changing: `darwin-rebuild changelog`.
  users.users.max = {
    name = "max";
    home = "/Users/max";
  };
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf

  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  # REQUIRED FOR NIX DARWIN TO PROPERLY SET THINGS
  programs.zsh.enable = true;
  # programs.home-manager.enable = true;

  #Home Manager Stuff
  # bash is enabled by default
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.max.imports = ./home.nix;
}
