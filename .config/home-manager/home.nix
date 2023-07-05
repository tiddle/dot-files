{ pkgs, config, lib, ... } :

let 
    name = "Carlo Cruz";
in
  {
    home.username = "carlo";
    home.homeDirectory = "/home/carlo";
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };

    home.packages = with pkgs; [
        htop
        thefuck
        nerdfonts
        nodejs_20
        vlc
        insomnia
        wget
        curl
        firefox
        ripgrep
    ];
    programs.zsh = {
        enable = true;
        shellAliases = {
            ll = "ls -l";
            vim = "nvim";
            update = "sudo nixos-rebuild switch";
            update-nixos = "sudo nixos-rebuild switch";
            update-home = "home-manager switch";
            edit-nixos = "sudo vim /etc/nixos/configuration.nix";
            edit-home = "vim ~/.config/home-manager/home.nix";
            wd="cd ~/Documents/workspace";
        };
        oh-my-zsh = {
            enable = true;
            plugins = ["git" "thefuck" ];
            theme = "bira";
        };
    };
    programs.neovim = {
        enable = true;
        withNodeJs = true;
        vimAlias = true;
        extraConfig = ''
            set number
            set cursorline

            inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
            inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
        '';
        extraLuaConfig = ''
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

        '';
	plugins = with pkgs.vimPlugins; [
	    vim-nix
            telescope-nvim
            vim-prettier
            nvim-treesitter-parsers.svelte
            coc-tailwindcss
            coc-html
            coc-css
            coc-prettier
            autosave-nvim
            nvchad
	];
        coc = {
          enable = true;
        };
    };
    programs.git = {
        enable = true;
        userName = "Carlo Cruz";
        userEmail = "me@carlocruz.com";
    };
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        svelte.svelte-vscode
        christian-kohler.path-intellisense
        bradlc.vscode-tailwindcss
      ];
    };
    programs.firefox = {
      enable = true;
      profiles.default = {
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          reddit-enhancement-suite
        ];
        settings = {
          "beacon.enabled" = false;
          "browser.contentblocking.category" = "strict";
          "browser.display.background_color" = "#c5c8c6";
          "browser.display.foreground_color" = "#1d1f21";
          "browser.download.dir" = "${config.home.homeDirectory}/download";
          "browser.safebrowsing.appRepURL" = "";
          "browser.safebrowsing.malware.enabled" = false;
          "browser.search.hiddenOneOffs" = "Google,Yahoo,Bing,Amazon.com,Twitter";
          "browser.search.suggest.enabled" = false;
          "browser.send_pings" = false;

          "browser.startup.page" = 3;
          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.uidensity" = 1; # Dense.
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "browser.urlbar.speculativeConnect.enabled" = false;
          "dom.battery.enabled" = false;
          "dom.event.clipboardevents.enabled" = false;
          "dom.security.https_only_mode" = true;
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.supported" = false;
          "extensions.pocket.enabled" = false;
          "general.smoothScroll" = false;
          "geo.enabled" = false;
          "gfx.webrender.all" = true;
          "layout.css.devPixelsPerPx" = "1";
          "media.navigator.enabled" = false;
          "media.video_stats.enabled" = false;
          "network.IDN_show_punycode" = true;
          "network.allow-experiments" = false;
          "network.dns.disablePrefetch" = true;
          "network.http.referer.XOriginPolicy" = 2;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "network.http.referer.trimmingPolicy" = 1;
          "network.prefetch-next" = false;
          "permissions.default.shortcuts" = 2; # Don't steal my shortcuts!
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.firstparty.isolate" = true;
          "signon.rememberSignons" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "widget.content.gtk-theme-override" = "Adwaita:light";
        };
      };
    };
    programs.tmux = {
        enable = true;
        mouse = true;
        extraConfig = ''
            set-option -g default-shell ${config.programs.zsh.package}/bin/zsh
            set -g base-index 1           # start windows numbering at 1
            setw -g pane-base-index 1     # make pane numbering consistent with windows

            setw -g automatic-rename on   # rename window to reflect current program
            set -g renumber-windows on    # renumber windows when a window is closed

            set -g set-titles on          # set terminal title

            set -g display-panes-time 800 # slightly longer pane indicators display time
            set -g display-time 1000      # slightly longer status messages display time

            set -g status-interval 10     # redraw status line every 10 seconds

            # split current window horizontally
            bind - split-window -v
            # split current window vertically
            bind | split-window -h

            # pane navigation
            bind -r h select-pane -L  # move left
            bind -r j select-pane -D  # move down
            bind -r k select-pane -U  # move up
            bind -r l select-pane -R  # move right
            bind > swap-pane -D       # swap current pane with the next one
            bind < swap-pane -U       # swap current pane with the previous one

            set -g prefix C-a
            unbind C-b
            bind C-a send-prefix

            set -g status-right '#{battery_status_bg} Batt: #{battery_icon} #{battery_percentage} #{battery_remain} | %a %h-%d %H:%M '
        '';
    };
    programs.alacritty = {
        enable = true;
        settings = {
            window = {
                padding.x = 8;
                padding.y = 8;
                opacity = 1;
            };
            font = {
                family = "DroidSansM Nerd Font";
            };
            colors = {
                # Default colors
                primary = {
                    background = "#303446"; # base
                    foreground = "#C6D0F5"; # text
                    # Bright and dim foreground colors
                    dim_foreground = "#C6D0F5"; # text
                    bright_foreground = "#C6D0F5"; # text
                };
                # Cursor colors
                cursor = {
                    text = "#303446"; # base
                    cursor = "#F2D5CF"; # rosewater
                };
                vi_mode_cursor = {
                    text = "#303446"; # base
                    cursor = "#BABBF1"; # lavender
                };
                
                # Search colors
                search = {
                    matches = {
                        foreground = "#303446"; # base
                        background = "#A5ADCE"; # subtext0
                        };
                    focused_match = {
                        foreground = "#303446"; # base
                        background = "#A6D189"; # green
                    };
                    footer_bar = {
                        foreground = "#303446"; # base
                        background = "#A5ADCE"; # subtext0
                    };
                };

                # Keyboard regex hints
                hints = {
                    start = {
                        foreground = "#303446"; # base
                        background = "#E5C890"; # yellow
                    };
                    end = {
                        foreground = "#303446"; # base
                        background = "#A5ADCE"; # subtext0
                    };
                };
                # Selection colors
                selection = {
                    text = "#303446"; # base
                    background = "#F2D5CF"; # rosewater
                };
                # Normal colors
                normal = {
                    black = "#51576D"; # surface1
                    red = "#E78284"; # red
                    green = "#A6D189"; # green
                    yellow = "#E5C890"; # yellow
                    blue = "#8CAAEE"; # blue
                    magenta = "#F4B8E4"; # pink
                    cyan = "#81C8BE"; # teal
                    white = "#B5BFE2"; # subtext1
                };
                # Bright colors
                bright = {
                    black = "#626880"; # surface2
                    red = "#E78284"; # red
                    green = "#A6D189"; # green
                    yellow = "#E5C890"; # yellow
                    blue = "#8CAAEE"; # blue
                    magenta = "#F4B8E4"; # pink
                    cyan = "#81C8BE"; # teal
                    white = "#A5ADCE"; # subtext0
                };
                # Dim colors
                dim = {
                    black = "#51576D"; # surface1
                    red = "#E78284"; # red
                    green = "#A6D189"; # green
                    yellow = "#E5C890"; # yellow
                    blue = "#8CAAEE"; # blue
                    magenta = "#F4B8E4"; # pink
                    cyan = "#81C8BE"; # teal
                    white = "#B5BFE2"; # subtext1
                };
            };
        };
    };

    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
}
