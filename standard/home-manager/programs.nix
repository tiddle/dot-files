{
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
        ll = "ls -l";
        wd = "cd ~/Documents/workspace";
        resethome = "home-manager switch --flake .#carlo@carlo-pc";
        resetnix = "sudo nixos-rebuild switch --flake .#carlo";
        addhome = "nix shell nixpkgs#home-manager";
    };
    oh-my-zsh = {
        enable = true;
        plugins = ["git" "thefuck" ];
        theme = "robbyrussell";
    };
  };
}