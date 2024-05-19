({pkgs, ...}: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "23.11";
  # specify my home-manager configs
  home.packages = with pkgs; [ripgrep fd curl less nil nixd alejandra nvim-pkg];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  programs = {
    bat = {
      enable = true;
      config = {theme = "TwoDark";};
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "ls --color=auto -F";
        nixswitch = "darwin-rebuild switch --flake ~/dots";
        nixre = "nixswitch";
        nixsave-unsafe = "f(){pushd ~/dots; git add .; git commit \"\$@\"; popd;}; f";
        nixsave = "f(){nixre && nixsave-unsafe \"\$@\" && echo \"nixsave Sucess\" || echo \"nixsave failed\";}; f";
        nixup = "pushd ~/dots; nix flake update; nixswitch; popd";
      };
      antidote = {
        enable = true;
        useFriendlyNames = true;
        plugins = [
          # "romkatv/powerlevel10k"
        ];
      };
    };
    starship = {
      enable = false;
      enableZshIntegration = true;
    };
    kitty = {
      enable = true;
      font = {
        name = "MesloLGS Nerd Font Mono";
        package = pkgs.nerdfonts;
        size = 24;
      };
    };
    alacritty = {
      enable = true;
      settings.font.normal.family = "MesloLGS Nerd Font Mono";
      settings.font.size = 16;
    };
  };
})
