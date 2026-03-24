{ pkgs, ... }: {
  home.packages = [ pkgs.nvm ];

  # AIDEV-NOTE: nvm needs to be sourced at shell init; NVM_DIR defaults to ~/.nvm
  programs.zsh.initExtra = ''
    export NVM_DIR="$HOME/.nvm"
    [ -s "${pkgs.nvm}/nvm.sh" ] && source "${pkgs.nvm}/nvm.sh"
    [ -s "${pkgs.nvm}/bash_completion" ] && source "${pkgs.nvm}/bash_completion"
  '';
}
