{ pkgs, inputs, ... }: {
  programs.neovim = {
    enable = true;
    # AIDEV-NOTE: home-manager wraps neovim-unwrapped internally; passing neovim causes lua attr error
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.neovim-unwrapped; # 0.11+
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
