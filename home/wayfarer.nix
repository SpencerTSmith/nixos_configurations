{ config, lib, pkgs, ... }: {
  home.username = "wayfarer";
  home.homeDirectory = "/home/wayfarer";

  imports = [
    ./modules/hyprland.nix
    ./modules/terminal.nix
    ./modules/neovim.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    nemo
    mate.engrampa
    celluloid
    imv
    pavucontrol
    hyprpicker
    transmission_4-gtk
    spotify

    gruvbox-plus-icons

    nerd-fonts.blex-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-extra

    (lib.hiPrio clang)
    gcc
    odin
    glfw
    libGL
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
    dataFile."icons/Gruvbox-Plus-Dark".source = "${pkgs.gruvbox-plus-icons}/share/icons/Gruvbox-Plus-Dark";
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
          background-color: @red_1;
        }

        button.titlebutton.maximize,
        windowcontrols > button.maximize > image,
        button.titlebutton.maximize:hover:backdrop,
        windowcontrols > button.maximize:hover:backdrop > image {
          background-color: #98971a;
        }

        button.titlebutton.maximize:hover,
        windowcontrols > button.maximize:hover > image {
          background-color: @green_1;
        }

        button.titlebutton.minimize,
        windowcontrols > button.minimize > image,
        button.titlebutton.minimize:hover:backdrop,
        windowcontrols > button.minimize:hover:backdrop > image {
          background-color: #d79921;
        }

        button.titlebutton.minimize:hover,
        windowcontrols > button.minimize:hover > image {
          background-color: @yellow_1;
        }

        button.titlebutton.close:backdrop,
        button.titlebutton.maximize:backdrop,
        button.titlebutton.minimize:backdrop,
        windowcontrols > button.close:backdrop > image,
        windowcontrols > button.maximize:backdrop > image,
        windowcontrols > button.minimize:backdrop > image {
          background-color: @light_5;
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

  programs.zathura = {
    enable = true;
    mappings = {
      "<C-i>" = "recolor";
    };
    options = {
      window-title-basename   = true;
      selection-clipboard     = "clipboard";
      notification-error-bg   = "#282828";
      notification-error-fg   = "#fb4934";
      notification-warning-bg = "#282828";
      notification-warning-fg = "#fabd2f";
      notification-bg         = "#282828";
      notification-fg         = "#b8bb26";
      completion-bg           = "#504945";
      completion-fg           = "#ebdbb2";
      completion-group-bg     = "#3c3836";
      completion-group-fg     = "#928374";
      completion-highlight-bg = "#83a598";
      completion-highlight-fg = "#504945";
      index-bg                = "#504945";
      index-fg                = "#ebdbb2";
      index-active-bg         = "#83a598";
      index-active-fg         = "#504945";
      inputbar-bg             = "#282828";
      inputbar-fg             = "#ebdbb2";
      statusbar-bg            = "#504945";
      statusbar-fg            = "#ebdbb2";
      highlight-color         = "#fabd2f";
      highlight-active-color  = "#fe8019";
      default-bg              = "#282828";
      default-fg              = "#ebdbb2";
      render-loading          = true;
      render-loading-bg       = "#282828";
      render-loading-fg       = "#ebdbb2";
      recolor-lightcolor      = "#282828";
      recolor-darkcolor       = "#ebdbb2";
      recolor                 = true;
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
