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
  };
  outputs = inputs: {
    darwinConfigurations."wand" =
      inputs.darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        pkgs = import inputs.nixpkgs { system = "x86_64-darwin"; };
        modules = [
          ({ pkgs, ... }: {
            users.users.max = {
              name = "max";
              home = "/Users/max";
            };
            # here go the darwin preferences and config items
            programs.zsh.enable = true;
            security.pam.enableSudoTouchIdAuth = true;
            environment.shells = [ pkgs.bash pkgs.zsh ];
            environment.loginShell = pkgs.zsh;
            environment.systemPackages = [ pkgs.coreutils ];
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
            system.keyboard.enableKeyMapping = true;
            system.keyboard.remapCapsLockToEscape = true;
            fonts.fontDir.enable = true; # DANGER
            fonts.fonts =
              [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
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
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.max.imports = [
                ({ pkgs, ... }: {
                  # Don't change this when you change package input. Leave it alone.
                  home.stateVersion = "23.11";
                  # specify my home-manager configs
                  home.packages = [ pkgs.ripgrep pkgs.fd pkgs.curl pkgs.less ];
                  home.sessionVariables = {
                    PAGER = "less";
                    CLICLOLOR = 1;
                    EDITOR = "nvim";
                  };
                  programs.bat.enable = true;
                  programs.bat.config.theme = "TwoDark";
                  programs.fzf.enable = true;
                  programs.fzf.enableZshIntegration = true;
                  programs.eza.enable = true;
                  programs.eza.enableZshIntegration = true;
                  programs.git.enable = true;
                  programs.zsh = {
                    enable = true;
                    enableCompletion = true;
                    autosuggestion.enable = true;
                    syntaxHighlighting.enable = true;
                    shellAliases = {
                      ls = "ls --color=auto -F";
                      nixswitch = "darwin-rebuild switch --flake ~/dots";
                      nixre = "nixswitch";
                      nixsave-unsafe = "f(){pushd ~/dots; git add .; git commit \"\$*\"; popd;}; f";
                      nixsave = "f(){nixre && nixsave-unsafe \"\$*\" && echo \"nixsave Sucess\" || echo \"nixsave failed\";}; f";
                      nixup = "pushd ~/dots; nix flake update; nixswitch; popd";
                    };
                  };
                  programs.starship.enable = true;
                  programs.starship.enableZshIntegration = true;
                  programs.alacritty = {
                    enable = true;
                    settings.font.normal.family = "MesloLGS Nerd Font Mono";
                    settings.font.size = 16;
                  };
                })
              ];
            };
          }
        ];
      };
  };
}
