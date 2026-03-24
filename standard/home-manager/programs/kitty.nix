{ pkgs, ... }: {
  home.sessionVariables.TERMINAL = "kitty";

  programs.kitty = {
    enable = true;
    font = {
      name = "DroidSansM Nerd Font Mono";
      size = 13;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      copy_on_select = true;
      window_padding_width = 8;
      confirm_os_window_close = 0;

      # Colours
      background_opacity = "0.95";
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      cursor = "#F5E0DC";
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";
    };
  };
}
