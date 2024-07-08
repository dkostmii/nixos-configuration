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
      codeium-nvim
    ];

    extraPackages = with pkgs; [
      cargo
      codeium
    ];

    extraLuaConfig = builtins.readFile(./init.lua);
  };

  xdg.configFile."nvim/lua/plugins/ai.lua" = {
    text = ''
    return {
      name = "codeium",
      dir = "${pkgs.vimPlugins.codeium-nvim}",
      opts = {
        tools = {
	        language_server = "${pkgs.codeium}/bin/codeium_language_server",
	      },
      },
      event = "BufEnter",
      dependencies = {
        "nvim-cmp",
        opts = function(_, opts)
          table.insert(opts.sources, { name = "codeium" })
        end,
      },
    }
    '';
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
