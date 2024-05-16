{ pkgs, ... }: {

  home.stateVersion = "23.11"; # read below
  home.packages = [ pkgs.ripgrep pkgs.curl pkgs.less pkgs.nil ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs = {
    home-manager.enable = true;
    bat.enable = true;
    bat.config.theme = "TwoDark";
    starship.enableZshIntegration = true;
    fzf.enable = true;
    fzf.enableZshIntegration = true;
    eza.enable = true;
    eza.enableZshIntegration = true;
    git.enable = true;
    zsh.enable = true;
    zsh =
      {
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = { ls = "ls --color=auto -F"; };
      };
    starship.enable = true;
    kitty = {
      enable = true;
      settings.font_family = "MesloLGS Nerd Font Mono";
      settings.font_size = 16;
    };

    alacritty = {
      enable = true;
      settings.font.normal.family = "MesloLGS Nerd Font Mono";
      settings.font.size = 16;
    };
  };
};
