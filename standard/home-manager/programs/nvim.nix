{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    extraConfig = ''
      set number
      set relativenumber
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent
      set wrap
      set ignorecase
      set smartcase
      set termguicolors
      set scrolloff=8
      set signcolumn=yes
      set updatetime=50
    '';
  };
}
