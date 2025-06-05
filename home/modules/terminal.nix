# Contains a complete terminal config for foot, zsh, tmux, and many other cli utilities
{ config, lib, pkgs, ... }: {
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
        source = "nixos";
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

  programs.git = {
    enable = true;
    userEmail = "spencertsmith2003@gmail.com";
    userName  = "SpencerTSmith";
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

  programs.yt-dlp = {
    enable = true;
    extraConfig = "-o ${config.xdg.userDirs.videos}/yt-dlp/%(title)s.%(ext)s";
  };

  programs.fd.enable = true;

  programs.ripgrep.enable = true;

}
