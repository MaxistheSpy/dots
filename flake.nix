{
  description = "my minimal flake";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # # LSP server for nix
    # nixd.url = "github:nix-community/nixd";
    # nixd.inputs.nixpkgs.follows = "nixpkgs";

    # # Alternate LSP
    # nil.url = "github:oxalica/nil";
    # nil.inputs.nixpkgs.follows = "nixpkgs";

    # # Formatter for nix
    # alejandra.url = "github:kamadorueda/alejandra";
    # alejandra.inputs.nixpkgs.follows = "nixpkgs";

    nivim.url = "github:MaxistheSpy/nivim";
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    darwin,
    nivim,
    ...
  }: {
    darwinConfigurations."wand" =
      darwin.lib.darwinSystem
      {
        system = "x86_64-darwin";
        pkgs = import nixpkgs {
          system = "x86_64-darwin";
          overlays = [
            nivim.overlays.default
          ];
        };
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {};
              users.max.imports = [
                ./home.nix
              ];
            };
          }
        ];
      };
  };
}
