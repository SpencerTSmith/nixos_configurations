# Just the lsps since mason is not the correct solution on nixos, don't really want to bother porting all my nvim configs over!
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
