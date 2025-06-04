{ config, lib, pkgs, ... }:
{
  home.username = "wayfarer";
  home.homeDirectory = "/home/wayfarer";

  home.packages = with pkgs; [
    neovim
    wl-clipboard
    nerd-fonts.blex-mono
    gruvbox-plus-icons
    nemo
    mate.engrampa
    celluloid
    imv
    pavucontrol
    hyprpicker
    transmission_4-gtk
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "less -R --use-color -Dd+r -Du+b";
    MANROFFOPT = "-c";
    NIXOS_OZONE_WL = "1";
  };

  home.shell = {
    enableZshIntegration = true;
  };

  home.preferXdgDirectories = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop   = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download  = "${config.home.homeDirectory}/downloads";
      music     = "${config.home.homeDirectory}/music";
      pictures  = "${config.home.homeDirectory}/pictures";
      videos    = "${config.home.homeDirectory}/videos";

      templates   = null;
      publicShare = null;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";

        "video/mp4" = "celluloid.desktop";
        "video/x-matroska" = "celluloid.desktop";
        "video/webm" = "celluloid.desktop";

        "audio/mpeg" = "celluloid.desktop";
        "audio/flac" = "celluloid.desktop";
        "audio/ogg" = "celluloid.desktop";
        "image/jpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/bmp" = "imv.desktop";

        "application/pdf" = "org.pwnt.zathura.desktop";
        "text/plain" = "neovim.desktop";

        "x-scheme-handler/magnet" = "transmission-gtk.desktop";
      };
    };
  };

  services.network-manager-applet.enable = true;
  services.playerctld.enable = true;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji     = ["BlexMono Nerd Font"];
      monospace = ["BlexMono Nerd Font Mono"];
      sansSerif = ["BlexMono Nerd Font Mono"];
    };
  };

  home.pointerCursor = {
    enable = true;
    dotIcons.enable = true;
    gtk.enable = true;
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox) - White";
    size = 16;
  };

  gtk =
  let css = ''
      @define-color accent_color #83a598;
      @define-color accent_bg_color mix(#83a598, #282828,0.3);
      @define-color accent_fg_color #ebdbb2;
      @define-color destructive_color #83a598;
      @define-color destructive_bg_color mix(#83a598, #282828,0.3);
      @define-color destructive_fg_color #ebdbb2;
      @define-color success_color #8ff0a4;
      @define-color success_bg_color #26a269;
      @define-color success_fg_color #ebdbb2;
      @define-color warning_color #f8e45c;
      @define-color warning_bg_color #cd9309;
      @define-color warning_fg_color rgba(0, 0, 0, 0.8);
      @define-color error_color #ff7b63;
      @define-color error_bg_color mix(#83a598, #282828,0.3);
      @define-color error_fg_color #ebdbb2;
      @define-color window_bg_color #282828;
      @define-color window_fg_color #ebdbb2;
      @define-color view_bg_color #282828;
      @define-color view_fg_color #ebdbb2;
      @define-color headerbar_bg_color #282828;
      @define-color headerbar_fg_color #ebdbb2;
      @define-color headerbar_border_color #ebdbb2;
      @define-color headerbar_backdrop_color @window_bg_color;
      @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
      @define-color card_bg_color rgba(255, 255, 255, 0.08);
      @define-color card_fg_color #ebdbb2;
      @define-color card_shade_color rgba(0, 0, 0, 0.36);
      @define-color dialog_bg_color #3c3836;
      @define-color dialog_fg_color #ebdbb2;
      @define-color popover_bg_color #3c3836;
      @define-color popover_fg_color #ebdbb2;
      @define-color shade_color rgba(0,0,0,0.36);
      @define-color scrollbar_outline_color rgba(0,0,0,0.5);
      @define-color blue_1 #83a598;
      @define-color blue_2 #83a598;
      @define-color blue_3 #83a598;
      @define-color blue_4 #83a598;
      @define-color blue_5 #83a598;
      @define-color green_1 #b8bb26;
      @define-color green_2 #b8bb26;
      @define-color green_3 #b8bb26;
      @define-color green_4 #b8bb26;
      @define-color green_5 #b8bb26;
      @define-color yellow_1 #fabd2f;
      @define-color yellow_2 #fabd2f;
      @define-color yellow_3 #fabd2f;
      @define-color yellow_4 #fabd2f;
      @define-color yellow_5 #fabd2f;
      @define-color orange_1 #fe8019;
      @define-color orange_2 #fe8019;
      @define-color orange_3 #fe8019;
      @define-color orange_4 #fe8019;
      @define-color orange_5 #fe8019;
      @define-color red_1 #fb4934;
      @define-color red_2 #fb4934;
      @define-color red_3 #fb4934;
      @define-color red_4 #fb4934;
      @define-color red_5 #fb4934;
      @define-color purple_1 #d3869b;
      @define-color purple_2 #d3869b;
      @define-color purple_3 #d3869b;
      @define-color purple_4 #d3869b;
      @define-color purple_5 #d3869b;
      @define-color brown_1 #d65d0e;
      @define-color brown_2 #d65d0e;
      @define-color brown_3 #d65d0e;
      @define-color brown_4 #d65d0e;
      @define-color brown_5 #d65d0e;
      @define-color light_1 #fbf1c7;
      @define-color light_2 #ebdbb2;
      @define-color light_3 #d5c4a1;
      @define-color light_4 #bdae93;
      @define-color light_5 #a89984;
      @define-color dark_1 mix(#282828,white,0.5);
      @define-color dark_2 mix(#282828,white,0.2);
      @define-color dark_3 #282828;
      @define-color dark_4 mix(#282828,black,0.2);
      @define-color dark_5 mix(#282828,black,0.4);

      :root {
        --accent-bg-color: @accent_bg_color;
        --accent-fg-color: @accent_fg_color;

        --destructive-bg-color: @destructive_bg_color;
        --destructive-fg-color: @destructive_fg_color;

        --success-bg-color: @success_bg_color;
        --success-fg-color: @success_fg_color;

        --warning-bg-color: @warning_bg_color;
        --warning-fg-color: @warning_fg_color;

        --error-bg-color: @error_bg_color;
        --error-fg-color: @error_fg_color;

        --window-bg-color: @window_bg_color;
        --window-fg-color: @window_fg_color;

        --view-bg-color: @view_bg_color;
        --view-fg-color: @view_fg_color;

        --headerbar-bg-color: @headerbar_bg_color;
        --headerbar-fg-color: @headerbar_fg_color;
        --headerbar-border-color: @headerbar_border_color;
        --headerbar-backdrop-color: @headerbar_backdrop_color;
        --headerbar-shade-color: @headerbar_shade_color;
        --headerbar-darker-shade-color: @headerbar_darker_shade_color;

        --sidebar-bg-color: @sidebar_bg_color;
        --sidebar-fg-color: @sidebar_fg_color;
        --sidebar-backdrop-color: @sidebar_backdrop_color;
        --sidebar-border-color: @sidebar_border_color;
        --sidebar-shade-color: @sidebar_shade_color;

        --secondary-sidebar-bg-color: @secondary_sidebar_bg_color;
        --secondary-sidebar-fg-color: @secondary_sidebar_fg_color;
        --secondary-sidebar-backdrop-color: @secondary_sidebar_backdrop_color;
        --secondary-sidebar-border-color: @secondary_sidebar_border_color;
        --secondary-sidebar-shade-color: @secondary_sidebar_shade_color;

        --card-bg-color: @card_bg_color;
        --card-fg-color: @card_fg_color;
        --card-shade-color: @card_shade_color;

        --dialog-bg-color: @dialog_bg_color;
        --dialog-fg-color: @dialog_fg_color;

        --popover-bg-color: @popover_bg_color;
        --popover-fg-color: @popover_fg_color;
        --popover-shade-color: @popover_shade_color;

        --thumbnail-bg-color: @thumbnail_bg_color;
        --thumbnail-fg-color: @thumbnail_fg_color;

        --shade-color: @shade_color;
        --scrollbar-outline-color: @scrollbar_outline_color;
      }

      tooltip {
        background-color: @dialog_bg_color;
      }

      tooltip * {
        color: @window_fg_color;
      }

      button.titlebutton.close,
      windowcontrols > button.close > image,
      button.titlebutton.close:hover:backdrop,
      windowcontrols > button.close:hover:backdrop > image {
        background-color: #cc241d;
      }

      button.titlebutton.close:hover,
      windowcontrols > button.close:hover > image {
        background-color: #fb4934;
      }

      button.titlebutton.maximize,
      windowcontrols > button.maximize > image,
      button.titlebutton.maximize:hover:backdrop,
      windowcontrols > button.maximize:hover:backdrop > image {
        background-color: #98971a;
      }

      button.titlebutton.maximize:hover,
      windowcontrols > button.maximize:hover > image {
        background-color: #b8bb26;
      }

      button.titlebutton.minimize,
      windowcontrols > button.minimize > image,
      button.titlebutton.minimize:hover:backdrop,
      windowcontrols > button.minimize:hover:backdrop > image {
        background-color: #d79921;
      }

      button.titlebutton.minimize:hover,
      windowcontrols > button.minimize:hover > image {
        background-color: #fabd2f;
      }

      button.titlebutton.close:backdrop,
      button.titlebutton.maximize:backdrop,
      button.titlebutton.minimize:backdrop,
      windowcontrols > button.close:backdrop > image,
      windowcontrols > button.maximize:backdrop > image,
      windowcontrols > button.minimize:backdrop > image {
        background-color: #665c54;
      }
      '';
  in {
      enable = true;
      font = {
        name = "BlexMono Nerd Font Propo";
        size = 11;
      };
      iconTheme = {
        package = pkgs.gruvbox-plus-icons;
        name = "Gruvbox-Plus-Dark";
      };
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };
      cursorTheme = {
        package = pkgs.capitaine-cursors-themed;
        name = "Capitaine Cursors (Gruvbox) - White";
        size = 16;
      };
      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      gtk3.extraCss = css;
      gtk4.extraCss = css;
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "browser.ml.linkPreview.enabled" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "history,bookmarks";
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.foot}/bin/foot";
        layer = "top";
        font = "BlexMono Nerd Font:size=12";
        icon-theme = "Gruvbox-Plus-Dark";
        icons-enabled = "yes";
        use-bold = "yes";
        prompt = "[RUN]: ";
        match-mode = "fzf";
        match-counter = "no";
        hide-before-typing = "no";
        lines = 20;
        inner-pad = 5;
        vertical-pad = 10;
        horizontal-pad = 10;
        launch-prefix = "uwsm app -- ";
        dpi-aware = "no";
        image-size-ratio = .5;
      };
      dmenu = {
        exit-immediately-if-empty = "yes";
      };
      border = {
        width = 2;
        radius = 0;
      };
      colors = {
        background = "282828f2";
        input = "fe8019ff";
        prompt = "fe8019ff";
        placeholder = "fe8019ff";
        text = "ebdbb2ff";
        match = "ebdbb2ff";
        selection = "3c3836f2";
        selection-text = "ebdbb2ff";
        selection-match = "b8bb26ff";
        border = "ebdbb2ff";
      };
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
      color = "always";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.btop = {
    enable = true;
    settings.color_theme = "gruvbox_dark_v2.theme";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      fg = "#ebdbb2";
      bg = "#282828";
      hl = "#fabd2f";
      "fg+" = "#ebdbb2";
      "bg+" = "#3c3836";
      "hl+" = "#fabd2f";
      info = "#83a598";
      prompt = "#bdae93";
      spinner = "#fabd2f";
      pointer = "#83a598";
      marker = "#fe8019";
      header = "#665c54";
    };
  };

  programs.fd = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "BlexMono Nerd Font:size=11";
        dpi-aware = "no";
        bold-text-in-bright="no";
      };
      scrollback.multiplier = 10;
      mouse.hide-when-typing = "yes";
      colors = {
        background = "282828";
        foreground = "ebdbb2";
        regular0   = "282828";
        regular1   = "fb4934";
        regular2   = "b8bb26";
        regular3   = "fabd2f";
        regular4   = "83a598";
        regular5   = "d3869b";
        regular6   = "8ec07c";
        regular7   = "a89984";
        bright0    = "928374";
        bright1    = "fb4934";
        bright2    = "b8bb26";
        bright3    = "fabd2f";
        bright4    = "83a598";
        bright5    = "d3869b";
        bright6    = "8ec07c";
        bright7    = "ebdbb2";
        alpha      = 0.90;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" ];
    };
    syntaxHighlighting.enable = true;
    autocd = true;
    dotDir = ".config/zsh";

    completionInit = ''
      autoload -Uz compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:descriptions' format '%B%d%b'
      zstyle ':completion:*:warnings' format 'No matches: %d'
      zmodload zsh/complist
      compinit
    '';

    initContent = ''
      setopt correct
      setopt glob_dots
      setopt always_to_end
      setopt complete_aliases
      setopt auto_menu
      setopt IGNORE_EOF
      setopt auto_param_slash
      setopt no_case_glob
      setopt no_case_match
      setopt globdots
      setopt extended_glob
      setopt interactive_comments

      bindkey -v
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey '^N' expand-or-complete
      bindkey '^P' reverse-menu-complete
      bindkey -M menuselect '^N' menu-complete
      bindkey -M menuselect '^P' reverse-menu-complete
      bindkey -v '^?' backward-delete-char
      bindkey -M vicmd 'k' history-search-backward
      bindkey -M vicmd 'j' history-search-forward
      KEYTIMEOUT=1
      ZLE_RPROMPT_INDENT=0

      zle-yank-to-clipboard() {
        echo -n "$BUFFER" | wl-copy
      }

      zle -N zle-yank-to-clipboard
      bindkey -M vicmd 'y' zle-yank-to-clipboard

      zle-paste-from-clipboard() {
        local clipboard_content=$(wl-paste)
          LBUFFER+="$clipboard_content"
      }

      zle -N zle-paste-from-clipboard
      bindkey -M vicmd 'p' zle-paste-from-clipboard

      zle-keymap-select () {
        case $KEYMAP in
          vicmd) echo -ne '\e[1 q';;      # block
          viins|main) echo -ne '\e[5 q';; # beam
          esac
      }

      zle -N zle-keymap-select

      zle-line-init() { echo -ne "\e[5 q"; }

      zle -N zle-line-init

      stty -ixon

      bindkey "^D" clear-screen
      bindkey "^L" list-choices
      bindkey -M vicmd "^D" clear-screen
      bindkey -M vicmd "^L" list-choices
    '';

    profileExtra = ''
      if [[ -z "$TMUX" ]] && uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';

    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.cacheHome}/zsh/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      saveNoDups = true;
      findNoDups = true;
      append = true;
      extended = true;
      share = true;
    };

    shellAliases = {
      mkdir = "mkdir -pv";
      rm = "rm -iv";
      cp = "cp -iv";
      mv = "mv -iv";
      chmod = "chmod -v";

      ls = "eza --icons --group-directories-first --color=auto";
      la = "eza -alh --icons --group-directories-first --color=auto";
      tree = "eza -T --icons --group-directories-first --color=auto";

      tma = "tmux attach || tmux new-session -s SCRATCH";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$line_break$character"
      ];
      palette = "gruvbox_dark";
      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_fg1 = "#ebdbb2";
        color_bg0 = "#282828";
        color_bg1 = "#3c3836";
        color_bg2 = "#504945";
        color_bg3 = "#665c54";
        color_blue = "#83a598";
        color_aqua = "#8ec07c";
        color_green = "#b8bb26";
        color_orange = "#fe8019";
        color_purple = "#d3869b";
        color_red = "#fb4934";
        color_yellow = "#fabd2f";
      };
      username = {
        show_always = true;
        style_user = "bold fg:color_blue";
        style_root = "bold fg:color_yellow";
        format = "[\\[](bold fg:color_fg1)[$user]($style)";
      };
      hostname = {
        ssh_only = false;
        style = "bold fg:color_orange";
        format = "[[@](bold fg:color_fg1)$ssh_symbol$hostname]($style)[\\]](bold fg:color_fg1)";
      };
      directory = {
        style = "bold fg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 15;
        truncation_symbol = "…/";
      };
      git_branch = {
        symbol = "";
        style = "bold fg:color_aqua";
        format = "[[ $symbol $branch ](bold fg:color_aqua)]($style)";
      };
      git_status = {
        style = "bold fg:color_aqua";
        format = "[[($all_status$ahead_behind )](bold fg:color_aqua)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bold fg:color_purple";
        format = "[  $time ]($style)";
      };
      line_break = {
        disabled = false;
      };
      character = {
        disabled = false;
        success_symbol = "[ ❯](bold fg:color_green)";
        error_symbol = "[ ❯](bold fg:color_red)";
        vimcmd_symbol = "[ ❮](bold fg:color_yellow)";
      };
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        padding = {
          top = 0;
        };
        color = {
          "1" = "green";
          "2" = "yellow";
        };
      };
      display = {
        separator = " ➜ ";
      };
      modules = [
        {
          type = "os";
          key = "OS";
          keyColor = "31";
        }
        {
          type = "kernel";
          key = " ├  ";
          keyColor = "31";
        }
        {
          type = "packages";
          format = "{} (nix)";
          key = " ├ 󰏖 ";
          keyColor = "31";
        }
        {
          type = "shell";
          key = " └  ";
          keyColor = "31";
        }
        "break"
        {
          type = "wm";
          key = "WM";
          keyColor = "32";
        }
        {
          type = "wmtheme";
          key = " ├ 󰉼 ";
          keyColor = "32";
        }
        {
          type = "icons";
          key = " ├ 󰀻 ";
          keyColor = "32";
        }
        {
          type = "cursor";
          key = " ├  ";
          keyColor = "32";
        }
        {
          type = "terminal";
          key = " ├  ";
          keyColor = "32";
        }
        {
          type = "terminalfont";
          key = " └  ";
          keyColor = "32";
        }
        "break"
        {
          type = "host";
          format = "{5} {1} Type {2}";
          key = "PC";
          keyColor = "33";
        }
        {
          type = "cpu";
          format = "{1} ({3}) @ {7} GHz";
          key = " ├  ";
          keyColor = "33";
        }
        {
          type = "gpu";
          format = "{1} {2} @ {12} GHz";
          key = " ├ 󰢮 ";
          keyColor = "33";
        }
        {
          type = "memory";
          key = " ├  ";
          keyColor = "33";
        }
        {
          type = "disk";
          key = " ├ 󰋊 ";
          keyColor = "33";
        }
        {
          type = "monitor";
          key = " └  ";
          keyColor = "33";
        }
        "break"
        "colors"
      ];
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-s";
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    focusEvents = true;
    sensibleOnTop = true;
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      {
        plugin = pkgs.tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-dir '${config.xdg.dataHome}/tmux/resurrect'";
      }
      {
        plugin = pkgs.tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'off'
          set -g @continuum-save-interval '1'
        '';
      }
    ];
    extraConfig = ''
      set -g default-command "''${SHELL} -i"
      set -g renumber-windows on

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X begin-selection \; send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy && wl-paste -n | wl-copy -p"
      unbind -T copy-mode-vi MouseDragEnd1Pane

      # copy mode highlighting
      set -wg copy-mode-match-style "bg=#a89984,fg=#3c3836"
      set -wg copy-mode-current-match-style "bg=#fe8019,fg=#3c3836"

      bind V split-window -v -c "#{pane_current_path}" -p 50
      bind v split-window -h -c "#{pane_current_path}" -p 50

      bind b split-window -v -c "#{pane_current_path}" -p 20

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind -r H resize-pane -L 1
      bind -r J resize-pane -D 1
      bind -r K resize-pane -U 1
      bind -r L resize-pane -R 1

      # Other Binds
      bind R source ~/.config/tmux/tmux.conf; display-message "Sourcing ~/.config/tmux/tmux.conf"
      bind s choose-session \; send-keys -X select-prompt "Kill session? (y/n)"
      bind C choose-session \; command-prompt -p "New session name:" "new-session -s '%%'"

      # Status bar config
      set -g status-position top
      set -wg automatic-rename on
      set -g automatic-rename-format "#{pane_current_command}"
      set -wg window-status-separator "|"
      set -wg monitor-activity on
      set -wg monitor-bell on

      set -g status-style "bg=#3c3836,fg=#a89984"
      set -wg mode-style "bg=#fe8019"

      set -wg window-status-activity-style "fg=#b8bb26"
      set -wg window-status-bell-style "fg=#fe8020"
      set -wg window-status-current-style "fg=#fe8019"

      set -g pane-active-border-style "fg=#ebdbb2"
      set -g pane-border-style "fg=#3c3836"
      set -g pane-border-lines single

      set -g message-style "fg=#b8bb26,bg=#3c3836,bold"

      set -g status-left "#[bold]#[bg=#fabd2f, fg=#282828]#{?client_prefix,#[bg=#b8bb26],#[bg=#fabd2f, fg=#282828]} #{session_name} "
      set -g status-right "#[bg=#3c3836, fg=#a89984] %I:%M %p | %Y-%m-%d #[bold]#[bg=#fabd2f, fg=#282828]#{?client_prefix,#[bg=#b8bb26],#[bg=#fabd2f]} #{host} "
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-justify left

      set -wg window-status-current-format "#[bold]#{?window_zoomed_flag,#[fg=default bold],#[fg=default]} #{window_index} #{window_name} "
      set -wg window-status-format "#{?window_zoomed_flag,#[fg=default bold],#[fg=default]} #{window_index} #{window_name} "
    '';
  };

  programs.yt-dlp = {
    enable = true;
    extraConfig = "-o ${config.xdg.userDirs.videos}/yt-dlp/%(title)s.%(ext)s";
  };

  programs.zathura = {
    enable = true;
    mappings = {
      "<C-i>" = "recolor";
    };
    options = {
      window-title-basename   = true;
      selection-clipboard     = "clipboard";
      notification-error-bg   = "#282828"; # bg
      notification-error-fg   = "#fb4934"; # bright:red
      notification-warning-bg = "#282828"; # bg
      notification-warning-fg = "#fabd2f"; # bright:yellow
      notification-bg         = "#282828"; # bg
      notification-fg         = "#b8bb26"; # bright:green
      completion-bg           = "#504945"; # bg2
      completion-fg           = "#ebdbb2"; # fg
      completion-group-bg     = "#3c3836"; # bg1
      completion-group-fg     = "#928374"; # gray
      completion-highlight-bg = "#83a598"; # bright:blue
      completion-highlight-fg = "#504945"; # bg2
      index-bg                = "#504945"; # bg2
      index-fg                = "#ebdbb2"; # fg
      index-active-bg         = "#83a598"; # bright:blue
      index-active-fg         = "#504945"; # bg2
      inputbar-bg             = "#282828"; # bg
      inputbar-fg             = "#ebdbb2"; # fg
      statusbar-bg            = "#504945"; # bg2
      statusbar-fg            = "#ebdbb2"; # fg
      highlight-color         = "#fabd2f"; # bright:yellow
      highlight-active-color  = "#fe8019"; # bright:orange
      default-bg              = "#282828"; # bg
      default-fg              = "#ebdbb2"; # fg
      render-loading          = true;
      render-loading-bg       = "#282828"; # bg
      render-loading-fg       = "#ebdbb2"; # fg
      # Recolor book content's color
      recolor-lightcolor      = "#282828"; # bg
      recolor-darkcolor       = "#ebdbb2"; # fg
      recolor                 = true;
      # set recolor-keephue     = true;      # keep original color
    };
  };

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      layer-shell-cover-screen = true;
      cssPriority = "user";
      control-center-margin-top = 5;
      control-center-margin-bottom = 5;
      control-center-margin-right = 5;
      control-center-margin-left = 5;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;
      relative-timestamps = true;
      control-center-width = 500;
      control-center-height = 600;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      text-empty = "";
      script-fail-notify = true;
      scripts = {
        example-script = {
          exec = "echo 'Do something...'";
          urgency = "Normal";
        };
        example-action-script = {
          exec = "echo 'Do something actionable!'";
          urgency = "Normal";
          run-on = "action";
        };
      };
      widgets = [
        "title"
        "notifications"
      ];
      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "";
          clear-all-button = true;
        };
        title = {
          text = "Notifications:";
          clear-all-button = true;
          button-text = "";
        };
        label = {
          max-lines = 5;
          text = "Label Text";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
          blacklist = [

          ];
        };
        buttons-grid = {
          actions = [
            {
              label = "";
              type = "toggle";
              active = true;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
              update-command = "sh -c '[[ $(nmcli radio wifi) == \"enabled\" ]] && echo true || echo false'";
            }
          ];
        };
        volume = {
          label = "󰕾";
          show-per-app = true;
          show-per-app-icon = true;
          show-per-app-label = true;
          expand-button-label = "";
          collapse-button-label = "";
        };
      };
    };
    style = ''
      @define-color bg_h #1d2021;
      @define-color bg   #282828;
      @define-color bg_s #32302f;
      @define-color bg1  #3c3836;
      @define-color bg2  #504945;
      @define-color bg3  #665c54;
      @define-color bg4  #7c6f64;

      @define-color fg  #fbf1c7;
      @define-color fg1 #ebdbb2;
      @define-color fg2 #d5c4a1;
      @define-color fg3 #bdae93;
      @define-color fg4 #a89984;

      @define-color red    #fb4934;
      @define-color green  #b8bb26;
      @define-color yellow #fabd2f;
      @define-color blue   #83a598;
      @define-color purple #d3869b;
      @define-color aqua   #8ec07c;
      @define-color gray   #928374;
      @define-color orange #fe8019;

      @define-color red-dim    #cc2412;
      @define-color green-dim  #98971a;
      @define-color yellow-dim #d79921;
      @define-color blue-dim   #458588;
      @define-color purple-dim #b16286;
      @define-color aqua-dim   #689d6a;
      @define-color gray-dim   #a89984;
      @define-color orange-dim #d65d0e;

      * {
        border-width: 2px;
        border-radius: 0;
        border-color: @fg1;
        background: transparent;
        color: @fg1;
        transition: all 0.2s ease-in-out;
      }

      .blank-window {
          background: transparent;
      }

      .control-center-list-placeholder {
          opacity: 0.5;
      }

      .control-center {
        border: 2px solid @fg1;
      }

      .widget-title {
        color: @orange;
      }

      .control-center,
      .control-center .notification-row,
      .close-button,
      .notification-default-action,
      .notification-action,
      .notification-row .notification-background .notification,
      .widget-title,
      .widget-dnd,
      .widget-label,
      .widget-buttons-grid,
      .widget-buttons-grid > flowbox > flowboxchild > button,
      .control-center-dnd,
      .control-center-clear-all {
        background: rgba(40, 40, 40, 0.9);
      }

      .control-center .notification-row:focus,
      .control-center .notification-row:hover,
      .close-button:hover,
      .notification-content:hover,
      .notification-default-action:hover,
      .notification-action:hover,
      .notification-row:hover,
      .notification-row .notification-background:hover,
      .notification-row .notification-background .close-button:hover,
      .notification-row .notification-background .notification:hover,
      .widget-title:hover,
      .widget-dnd:hover,
      .widget-label:hover,
      .widget-buttons-grid > flowbox > flowboxchild > button:hover,
      .control-center-dnd:hover,
      .control-center-clear-all:hover {
        background: @bg1;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
        background: @blue;
      }

      .widget-dnd > switch:checked {
        background: @red;
      }

      .widget-dnd > switch slider {
        background: @fg1;
      }

      .notification-row .notification-background .close-button {
        color: @fg1;
        text-shadow: none;
        padding: 0;
        box-shadow: none;
        min-width: 24px;
        min-height: 24px;
      }

      .widget-volume {
        color: @fg1;
      }
    '';
  };

  xdg.configFile."waybar/config" = {
    onChange = ''
      ${pkgs.procps}/bin/pkill -SIGUSR2 waybar || true
    '';
  };
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 30;
        margin-top = 0;
        margin-right = 0;
        margin-left = 0;
        margin-bottom = 0;
        reload_style_on_change = true;
        modules-left = [
          "hyprland/workspaces"
          "group/hardware"
          "battery"
          "custom/line"
          "group/power"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "group/actions"
          "custom/line"
          "mpris"
          "wireplumber"
          "backlight"
          "clock"
          "custom/notification"
          "tray"
        ];
        "hyprland/workspaces" = {
          format = " {icon} ";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            urgent = "";
            default = "";
          };
          persistent-workspaces = {
            HDMI-A-6 = [
              1
              2
            ];
            DP-4 = [
              3
              4
            ];
            eDP-1 = [
              1
              2
              3
              4
            ];
          };
        };
        "custom/line" = {
          format = "│";
          tooltip = false;
        };
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          icon = true;
          icon-size = 15;
          on-click = "$HOME/.config/scripts/fuzzel-windows.sh";
          tooltip = false;
          separate-outputs = true;
        };
        mpris = {
          format = " {dynamic} {player_icon} ";
          format-paused = " {dynamic} {status_icon} ";
          format-stopped = " {dynamic} {status_icon} ";
          player-icons = {
            default = "";
            firefox = "";
            spotify = "";
          };
          status-icons = {
            paused = "";
            stopped = "";
          };
          dynamic-len = 50;
          dynamic-order = [
            "title"
            "artist"
            "album"
          ];
          dynamic-separator = " - ";
        };
        tray = {
          icon-size = 15;
          spacing = 15;
          show-passive-items = false;
        };
        clock = {
          format = " {:%I:%M %p}  ";
          format-alt = " {:%A, %B %d, %Y (%R)}  ";
          tooltip-format = "<tt><big>{calendar}</big></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#fabd2f'><b><i>{}</i></b></span>";
              days = "{}";
              weeks = "<span color='#8ec07c'><b>W{}</b></span>";
              weekdays = "<span color='#b8bb26'><b>{}</b></span>";
              today = "<span color='#fe8019'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        wireplumber = {
          format = " {volume}% {icon} ";
          tooltip = true;
          max-volume = 120;
          scroll-step = 5;
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        backlight = {
          device = "intel_backlight";
          format = " {percent}% {icon} ";
          format-icons = [
            "󰃚"
            "󰃛"
            "󰃜"
            "󰃞"
            "󰃝"
            "󰃟"
            "󰃠"
          ];
          on-scroll-up = "brightnessctl set +1%";
          on-scroll-down = "brightnessctl set 1%-";
          smooth-scrolling-threshold = 1;
          tooltip = false;
        };
        "custom/notification" = {
          tooltip = false;
          format = " {} {icon} ";
          format-icons = {
            notification = "󱅫";
            none = "󰂚";
            dnd-notification = "󱏧";
            dnd-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
        "custom/updates" = {
          format = " {icon} ";
          tooltip = true;
          format-icons = "";
          interval = "once";
          exec = "$HOME/.config/scripts/check-updates.sh";
          return-type = "json";
          on-click = "hyprctl dispatch exec \"[float] foot -e paru\" && pkill -SIGRTMIN+10 waybar";
          signal = 10;
        };
        "custom/kill" = {
          format = " {icon} ";
          tooltip = true;
          tooltip-format = "Kill process";
          format-icons = "󱎘";
          on-click = "$HOME/.config/scripts/fuzzel-kill.sh";
        };
        "custom/wallpaper" = {
          format = " {icon} ";
          tooltip = true;
          tooltip-format = "Change wallpaper";
          format-icons = "";
          on-click = "$HOME/.config/scripts/fuzzel-wallpaper.sh";
        };
        "custom/hyprpicker" = {
          format = " {icon} ";
          tooltip = true;
          tooltip-format = "Color picker";
          format-icons = "";
          on-click = "hyprpicker -laq";
        };
        "custom/hyprsunset" = {
          format = " {icon} ";
          tooltip = true;
          tooltip-format = "Toggle color temperature";
          format-icons = "";
          on-click = "hyprctl hyprsunset temperature 3500";
        };
        "custom/shutdown" = {
          format = " {icon} ";
          format-icons = "";
          tooltip-format = "Shutdown";
          on-click = "systemctl poweroff";
        };
        "custom/reboot" = {
          format = " {icon} ";
          format-icons = "";
          tooltip-format = "Reboot";
          on-click = "systemctl reboot";
        };
        "custom/lock" = {
          format = " {icon} ";
          format-icons = "";
          tooltip-format = "Lock";
          on-click = "hyprlock";
        };
        "custom/suspend" = {
          format = " {icon} ";
          format-icons = "󰒲";
          tooltip-format = "Suspend";
          on-click = "systemctl suspend";
        };
        "custom/exit" = {
          format = " {icon} ";
          format-icons = "󰍃";
          tooltip-format = "Exit";
          on-click = "uwsm stop";
        };
        cpu = {
          format = " {usage}%  ";
          tooltip = true;
          on-click = "hyprctl dispatch exec \"[float;size 1000 800] foot -e btop\"";
          interval = 5;
        };
        memory = {
          format = " {}%  ";
          tooltip = true;
          on-click = "hyprctl dispatch exec \"[float;size 1000 800] foot -e btop\"";
          interval = 5;
        };
        temperature = {
          thermal-zone = 2;
          hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
          critical-threshold = 90;
          format = " {temperatureC}°C {icon} ";
          format-icons = [
            ""
            ""
            ""
          ];
          tooltip = false;
          on-click = "hyprctl dispatch exec \"[float;size 1000 800] foot -e btop\"";
          interval = 5;
        };
        disk = {
          interval = 3600;
          format = " {percentage_used}%  ";
          path = "/";
          on-click = "hyprctl dispatch exec \"[float;size 1000 800] foot -e btop\"";
        };
        network = {
          format = " {bandwidthDownBits}  {bandwidthUpBits}  ";
          on-click = "hyprctl dispatch exec \"[float;size 1000 800] foot -e btop\"";
          tooltip-format = "{ifname} via {gwaddr}";
        };
        "custom/gpu" = {
          format = " {}%  ";
          exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          interval = 5;
          tooltip = false;
          on-click = "hyprctl dispatch exec \"[float;size 1000 800] foot -e btop\"";
        };
        battery = {
          interval = 30;
          states = {
            warning = 30;
            critical = 15;
          };
          format = " {capacity}% {icon} ";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          max-length = 25;
          on-click = "hyprctl dispatch exec \"[float;size 1000 800] foot -e btop\"";
        };
        "group/hardware" = {
          orientation = "inherit";
          modules = [
            "cpu"
            "temperature"
            "memory"
            "custom/gpu"
            "disk"
          ];
        };
        "group/actions" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 200;
            children-class = "actions-child";
            transition-left-to-right = false;
          };
          modules = [
            "custom/updates"
            "custom/kill"
            "custom/wallpaper"
            "custom/hyprpicker"
            "custom/hyprsunset"
          ];
        };
        "group/power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 200;
            children-class = "power-child";
            transition-left-to-right = true;
          };
          modules = [
            "custom/shutdown"
            "custom/reboot"
            "custom/lock"
            "custom/suspend"
            "custom/exit"
          ];
        };
      };
    };

    style = ''
      @define-color bg_h #1d2021;
      @define-color bg   #282828;
      @define-color bg_s #32302f;
      @define-color bg1  #3c3836;
      @define-color bg2  #504945;
      @define-color bg3  #665c54;
      @define-color bg4  #7c6f64;

      @define-color fg  #fbf1c7;
      @define-color fg1 #ebdbb2;
      @define-color fg2 #d5c4a1;
      @define-color fg3 #bdae93;
      @define-color fg4 #a89984;

      @define-color red    #fb4934;
      @define-color green  #b8bb26;
      @define-color yellow #fabd2f;
      @define-color blue   #83a598;
      @define-color purple #d3869b;
      @define-color aqua   #8ec07c;
      @define-color gray   #928374;
      @define-color orange #fe8019;

      @define-color red-dim    #cc2412;
      @define-color green-dim  #98971a;
      @define-color yellow-dim #d79921;
      @define-color blue-dim   #458588;
      @define-color purple-dim #b16286;
      @define-color aqua-dim   #689d6a;
      @define-color gray-dim   #a89984;
      @define-color orange-dim #d65d0e;

      * {
        border-width: 0;
      	border-radius: 0;
      	border-style: solid;
      	color: @fg1;
        transition: all 0.2s ease-in-out;
        min-height: 0;
      	border-color: @fg1;
        margin: 0;
        padding:0;
      }

      tooltip,
      .modules-right,
      .modules-center,
      .modules-left,
      window#waybar {
      	background-color: @bg;
      }

      window#waybar.empty #window {
        background-color: transparent;
      	color: transparent;
      }

      .modules-left > widget:first-child > #workspaces {
      	margin-left: 0px;
      }

      .modules-right > widget:last-child > #workspaces {
      	margin-right: 0px;
      }

      #tray {
      	padding-right: 0.6em;
      	padding-left: 0.6em;
      }

      #tray > .passive {
      	-gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
      	-gtk-icon-effect: highlight;
      }

      #window {
      	padding-right:0.6em;
      	padding-left:0.6em;
      }

      #battery,
      #cpu,
      #memory,
      #temperature,
      #wireplumber,
      #clock,
      #custom-shutdown,
      #custom-updates,
      #custom-notification,
      #custom-hyprpicker,
      #disk,
      #network,
      #custom-gpu,
      #mpris,
      #window,
      #custom
      #custom-shutdown,
      #custom-kill,
      #custom-reboot,
      #custom-lock,
      #custom-suspend,
      #custom-updates,
      #custom-wallpaper,
      #custom-hyprsunset,
      #backlight,
      #custom-exit {
        background-color: @bg;
      }

      #custom-shutdown:hover,
      #custom-updates:hover,
      #custom-kill:hover,
      #custom-reboot:hover,
      #custom-lock:hover,
      #custom-suspend:hover,
      #custom-updates:hover,
      #custom-hyprpicker:hover,
      #custom-exit:hover,
      #battery:hover,
      #cpu:hover,
      #memory:hover,
      #temperature:hover,
      #wireplumber:hover,
      #clock:hover,
      #window:hover,
      #custom-shutdown:hover,
      #custom-updates:hover,
      #custom-notification:hover,
      #custom-wallpaper:hover,
      #disk:hover,
      #network:hover,
      #custom-gpu:hover,
      #custom-hyprsunset:hover,
      #mpris:hover,
      #backlight:hover {
        background-color: @bg1;
      }

      #tray,
      #workspaces {
      	background-color: @bg2;
      }

      #tray:hover,
      #workspaces:hover {
        background-color: @bg3;
      }

      #workspaces button.active label,
      #custom-notification,
      #custom-suspend,
      #battery,
      #custom-wallpaper {
      	color: @aqua;
      }

      #wireplumber.muted,
      #temperature.critical,
      #custom-notification.dnd-none,
      #custom-notification.dnd-notification,
      #battery.critical,
      #custom-kill {
      	color: @red;
      }

      #custom-shutdown,
      #mpris {
      	color: @green;
      }

      #cpu,
      #wireplumber,
      #custom-reboot,
      #custom-hyprsunset,
      #custom-updates.updates-available,
      #battery.warning,
      #network {
      	color: @yellow;
      }

      #clock,
      #custom-exit,
      #custom-gpu {
      	color: @orange;
      }

      #memory,
      #custom-lock,
      #custom-hyprpicker,
      #backlight {
      	color: @purple;
      }

      #temperature,
      #custom-updates {
      	color: @blue;
      }

      #disk {
      	color: @gray;
      }

      #workspaces button:hover {
      	color: @fg1;
      }
    '';
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 3;
        noise = 0.0117;
        contrast = 1.0;
        brightness = 1.0;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
      animation = {
        enabled = true;
        animation = [ "fade, 1, 2, default" "inputField, 1, 2, default" ];
      };
      shape = {
        size = "500, 250";
        color = "rgb(282828)";
        rounding = 0;
        border_size = 3;
        border_color = "rgb(ebdbb2)";
        rotate = 0;
        xray = false;
        position = "0, 0";
        halign = "center";
        valign = "center";
      };
      input-field = {
        size = "350, 50";
        outline_thickness = 3;
        dots_size = 0.3;
        dots_spacing = 0.2;
        dots_center = true;
        dots_rounding = 0;
        dots_text_format = "*";
        outer_color = "rgb(83a598)";
        inner_color = "rgb(ebdbb2)";
        font_family = "BlexMono Nerd Font";
        font_color = "$bg";
        fade_on_empty = false;
        fade_timeout = 1000;
        placeholder_text = "<i>$PAMPROMPT</i>";
        hide_input = false;
        rounding = 0;
        check_color = "rgb(fabd2f)";
        fail_color = "rgb(fb4934)";
        fail_text = "<i>$PAMFAIL <b>($ATTEMPTS)</b></i>";
        fail_timeout = 200;
        fail_transition = 200;
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1;
        invert_numlock = false;
        swap_font_color = true;
        position = "0, 0";
        halign = "center";
        valign = "center";
      };
      label = [
        {
          text = "$USER";
          text_align = "left";
          color = "rgb(ebdbb2)";
          font_size = 25;
          font_family = "BlexMono Nerd Font";
          rotate = 0;
          position = "0, 60";
          halign = "center";
          valign = "center";
        }
        {
          text = "$TIME12";
          text_align = "center";
          color = "rgb(ebdbb2)";
          font_size = 25;
          font_family = "BlexMono Nerd Font";
          rotate = 0;
          position = "0, -60";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${config.xdg.userDirs.pictures}/wallpapers/subway.jpg" ];
      wallpaper = [ ", ${config.xdg.userDirs.pictures}/wallpapers/subway.jpg" ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 3600;
          on-timeout = "systemctl shutdown";
        }
      ];
    };
  };

  services.hyprsunset.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "foot";
      "$browser" = "firefox";
      "$menu" = "fuzzel";
      "$fileManager" = "nemo";

      monitor = [
        "HDMI-A-6, highres@highrr, 0x0, 1"
          "DP-4, highres@highrr, 2560x0, 1"
          ", preferred, auto, 1"
      ];

      exec-once = [
        "systemctl --user enable --now hypridle"
        "systemctl --user enable --now hyprpaper"
        "systemctl --user enable --now hyprsunset"
        "systemctl --user enable --now waybar"
        "systemctl --user enable --now swaync"
        "systemctl --user enable --now foot-server"
        "uwsm app -- nm-applet"
        "uwsm app -- blueman-applet"
        "uwsm app -- /usr/lib/mate-polkit/polkit-mate-authentication-agent-1"
        "uwsm app -- wl-paste --watch cliphist store"
        "uwsm app -- tmux start-server"
      ];

      input = {
        kb_layout = "us";
        repeat_delay = 300;
        repeat_rate = 75;
        sensitivity = 0;
      };

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bind = [
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, grave, togglespecialworkspace, dropdown"

        "$mainMod, W, exec, [workspace 1 silent] uwsm app -- $browser"
        "$mainMod, W, workspace, 1"
        "$mainMod, M, exec, [workspace 2 silent] uwsm app -- spotify"
        "$mainMod, M, workspace, 2"
        "$mainMod, Q, exec, [workspace 3 silent] uwsm app -- $terminal"
        "$mainMod, Q, workspace, 3"
        "$mainMod, S, exec, [workspace 4 silent] uwsm app -- steam"
        "$mainMod, S, workspace, 4"

        "$mainMod, E, exec, uwsm app -- $fileManager"
        "$mainMod, R, exec, $menu"

        "$mainMod, B, exec, killall -SIGUSR2 waybar"

        "$mainMod, P, exec, $HOME/.config/scripts/fuzzel-power-menu.sh"
        "$mainMod, Y, exec, $HOME/.config/scripts/fuzzel-cliphist.sh"
        "$mainMod, G, exec, $HOME/.config/scripts/fuzzel-files.sh"
        "$mainMod, O, exec, $HOME/.config/scripts/fuzzel-windows.sh"
        "$mainMod, A, exec, $HOME/.config/scripts/fuzzel-actions.sh"

        "$mainMod, N, exec, swaync-client -t -sw"

        "$mainMod, Print, exec, grimblast --notify copy area"
        "$mainMod SHIFT, Print, exec, grimblast --notify save area"

        "$mainMod, C, killactive"
        "$mainMod, T, togglesplit"
        "$mainMod, V, togglefloating"
        "$mainMod, F, fullscreen"

        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainMod SHIFT, h, resizeactive, -50 0"
        "$mainMod SHIFT, l, resizeactive, 50 0"
        "$mainMod SHIFT, k, resizeactive, 0 50"
        "$mainMod SHIFT, j, resizeactive, 0 -50"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioStop, exec, playerctl stop"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        "col.active_border" = "rgb(ebdbb2)";
        "col.inactive_border" = "rgb(504945)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        rounding_power = 4.0;

        active_opacity   = 1.0;
        inactive_opacity = 1.0;

        shadow.enabled = false;

        blur = {
          enabled = true;
          size = 2;
          passes = 2;
          new_optimizations = true;
          contrast = 1.0;
          brightness = 1.0;
          vibrancy = 1.0;
        };
      };

      animations = {
        enabled = true;
        bezier = [ "myBezier, 0.1, 0.75, 0.27, 0.99" ];

        animation = [
          "windows, 1, 2, myBezier, slide"
          "windowsOut, 1, 2, myBezier, slide"
          "border, 1, 2, myBezier"
          "borderangle, 0, 2, myBezier"
          "fade, 1, 2, myBezier"
          "workspaces, 1, 2, myBezier"
          "layers, 1, 2, myBezier"
          "layersOut, 1, 2, myBezier, slide"

          "specialWorkspace, 1, 2, myBezier, slidefadevert -50%"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
       	force_default_wallpaper = 1;
       	disable_hyprland_logo = true;
       	middle_click_paste = false;
       	animate_manual_resizes = true;
       	vrr = 0;
        font_family = "BlexMono Nerd Font";
      };

      cursor = {
      	warp_on_change_workspace = true;
      	no_hardware_cursors = true;
      	inactive_timeout = 5;
      };

      gestures.workspace_swipe = false;

      workspace = [
        "name:1, monitor:HDMI-A-6"
        "name:2, monitor:HDMI-A-6"
        "name:3, monitor:DP-4"
        "name:4, monitor:DP-4"

        "special:dropdown, on-created-empty:[float; size 100% 30%; move 0 30] foot, gapsout:0, border:false"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "idleinhibit fullscreen, class:^*$"
        "idleinhibit fullscreen, title:^*$"
        "idleinhibit fullscreen, fullscreen:1"
        "nofocus, class:steam, title:^notificationtoasts_.*_desktop$"

        "float, class:(dialog|splash|floating|pavucontrol|blueman-manager|imv|nm-connection-editor|org.pulseaudio.pavucontrol|nwg-look|engrampa)"
        "size 900 700, class:(dialog|splash|floating|pavucontrol|blueman-manager|imv|nm-connection-editor|org.pulseaudio.pavucontrol|nwg-look|engrampa)"

        "workspace 1, class:(firefox)"
        "workspace 2, class:(Spotify)"
        "workspace 3, class:(terminal)"
        "workspace 4, class:(steam)"
      ];

      layerrule = [
        "animation slide, launcher"
        "blur, launcher"
        "ignorezero, launcher"
        "animation slide, notifications"
        "blur, notifications"
        "ignorezero, notifications"
        "animation slide top, swaync-control-center"
        "blur, swaync-control-center"
        "ignorezero, swaync-control-center"
        "animation slide, swaync-notification-window"
        "blur, swaync-notification-window"
        "ignorezero, swaync-notification-window"
        "animation slide, waybar"
        "blur, waybar"
        "ignorezero, waybar"
      ];
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
