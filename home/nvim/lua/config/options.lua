-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.background = 'dark'
vim.opt.listchars = {
  trail = '@',
  tab = '<' .. string.rep('-', vim.opt.tabstop:get() - 2) .. '>',
  space = '~',
  nbsp = '+',
  eol = '$',
}
