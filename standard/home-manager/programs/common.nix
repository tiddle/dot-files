{ pkgs, ... }: {
  home.packages = with pkgs; [
    thefuck
    wget
    curl
    ripgrep
    neofetch
    lazygit
    discord
    vlc
    mpv
    kdePackages.spectacle
    wallch
    chromium
    mangohud
    nodejs
    (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
  ];

  fonts.fontconfig.enable = true;

  # npm global installs go to ~/.npm-global — no sudo needed
  home.sessionVariables.NPM_CONFIG_PREFIX = "$HOME/.npm-global";
  home.sessionPath = [ "$HOME/.npm-global/bin" ];

  programs = {
    bottom.enable = true;
    eza.enable = true;
    home-manager = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      userName = "Carlo Cruz";
      userEmail = "me@carlocruz.com";
    };
    zsh = {
      enable = true;
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
          file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
      ];
      shellAliases = {
          ls = "eza";
          ll = "ls -l";
          wd = "cd ~/Documents/workspace";
          resethome = "home-manager switch --flake .#carlo@carlo-pc";
          resetnix = "sudo nixos-rebuild switch --flake .#carlo-pc";
          addhome = "nix shell nixpkgs#home-manager";
      };
      oh-my-zsh = {
          enable = true;
          plugins = ["git" "thefuck"];
          theme = "robbyrussell";
      };
    };
  };
}