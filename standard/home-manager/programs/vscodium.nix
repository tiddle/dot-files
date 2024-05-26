{
  pkgs,
  config,
  lib,
  ...
}:  {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      svelte.svelte-vscode
      christian-kohler.path-intellisense
      bradlc.vscode-tailwindcss
    ];
  };
}
