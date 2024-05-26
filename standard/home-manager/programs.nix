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
    };
    oh-my-zsh = {
        enable = true;
        plugins = ["git" "thefuck" ];
        theme = "bira";
    };
  };
}