{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    catppuccin.enable = false;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      cargo
      codeium
    ];

    extraLuaConfig = builtins.readFile(./init.lua);
  };

  xdg.configFile."nvim/lua/config/lazy.lua" = {
    text = builtins.readFile(./lua/config/lazy.lua);
  };

  xdg.configFile."nvim/lua/config/filetypes.lua" = {
    text = builtins.readFile(./lua/config/filetypes.lua);
  };

  xdg.configFile."nvim/lua/config/keymaps.lua" = {
    text = builtins.readFile(./lua/config/keymaps.lua);
  };

  xdg.configFile."nvim/lua/config/options.lua" = {
    text = builtins.readFile(./lua/config/options.lua);
  };

  xdg.configFile."nvim/lua/plugins/colorscheme.lua" = {
    text = builtins.readFile(./lua/plugins/colorscheme.lua);
  };
}
