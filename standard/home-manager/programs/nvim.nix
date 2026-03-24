{ pkgs, inputs, ... }: {
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim; # 0.11+ from unstable
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  # NvChad starter config — plugins are fetched by lazy.nvim on first launch
  xdg.configFile."nvim" = {
    source = inputs.nvchad-starter;
    recursive = true;
  };
}
