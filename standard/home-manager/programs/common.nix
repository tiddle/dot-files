{
  lib,
  pkgs,
  catppuccin-bat,
  ...
}: {
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    thefuck
    nerdfonts
    nodePackages_latest.nodejs
    wget
    curl
    ripgrep
    neofetch
  ];

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
    git = {
      enable = true;
      userName = "Carlo Cruz";
      userEmail = "me@carlocruz.com";
    };
    zsh = {
      enable = true;
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