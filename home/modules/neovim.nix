# Contains a pretty minimal (but featureful) neovim configuration
#   - lsp, completions, qol
{ config, lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;

    defaultEditor = true;

    viAlias      = true;
    vimdiffAlias = true;
    vimAlias     = true;

    extraPackages =  [
      pkgs.clang-tools
      pkgs.glsl_analyzer
      pkgs.nixd
      pkgs.bash-language-server
      pkgs.ols
      pkgs.lua-language-server
    ];
  };
}
