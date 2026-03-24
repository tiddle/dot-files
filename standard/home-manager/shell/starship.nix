{config, ...}: {
  home.sessionVariables.STARSHIP_CACHE = "${config.home.homeDirectory}/.cache/starship";

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };
    };
  };
}